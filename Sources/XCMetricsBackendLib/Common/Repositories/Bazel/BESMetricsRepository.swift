//
// Created by Zachary Gray on 2/25/21.
//

import Fluent
import Foundation
import PublishBuildEventProto
import GRPC
import NIO
import NIOHPACK
import SwiftProtobuf

typealias BESClient = Google_Devtools_Build_V1_PublishBuildEventServiceClient
typealias StreamResponse = Google_Devtools_Build_V1_PublishBuildToolEventStreamResponse
typealias StreamCall = BidirectionalStreamingCall<Google_Devtools_Build_V1_PublishBuildToolEventStreamRequest, Google_Devtools_Build_V1_PublishBuildToolEventStreamResponse>
typealias StreamReq = Google_Devtools_Build_V1_PublishBuildToolEventStreamRequest

struct BESMetricsRepository : MetricsRepository {
    let logger: Logger
    let besConfig: BESConfig
    let dispatchGroup = DispatchGroup()
    let dispatchQueue = DispatchQueue(
            label: "com.spotify.xcmetrics.bes",
            qos: .default,
            attributes: [.concurrent])

    init(logger: Logger, besConfig: BESConfig) {
        self.logger = logger
        self.besConfig = besConfig
    }

    private func initClient(group: EventLoopGroup) -> BESClient? {
        do {
            let secure: Bool = besConfig.target.scheme != nil
                    && besConfig.target.scheme.unsafelyUnwrapped.contains("grpcs")
            let ccc = ClientConnection.Configuration(
                    target: .hostAndPort(besConfig.target.host!, besConfig.target.port!.intValue),
                    eventLoopGroup: group,
                    tls:  secure ? ClientConnection.Configuration.TLS() : nil)

            let cc = ClientConnection(configuration: ccc)
            let co = CallOptions(
                    customMetadata: HPACKHeaders([
                        ("Authorization", besConfig.authToken),
                        // todo: set some other Bazel bits here;
                        // iirc, Bazel sets the reapi.RequestMetadata binary header maybe?
                    ]),
                    timeout: try .seconds(30))

            return .some(BESClient(connection: cc, defaultCallOptions: co))
        } catch {
            logger.error("Error creating server connection: \(error)")
        }
        return .none
    }

    func insertBuildMetrics(_ buildMetrics: BuildMetrics, using eventLoop: EventLoop) -> EventLoopFuture<Void> {
        // todo: is there a better event loop to use here?
        // do we ever want more threads? these events need to send in sequence, so not sure if there's any point.
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let client = initClient(group: group)
        defer {
            do {
                try group.syncShutdownGracefully()
                _ = client?.connection.close()
            } catch {
                logger.error("Error closing event group: \(error.localizedDescription)")
            }
        }

        var expectedAckSequenceNumber: Int64 = -1
        let stream: StreamCall? = client?.publishBuildToolEventStream(handler: { ack in
            assert(expectedAckSequenceNumber == ack.sequenceNumber)
        })
        do {
            for req in createRequestsFor(build: buildMetrics) {
                expectedAckSequenceNumber = req.orderedBuildEvent.sequenceNumber
                try stream?.sendMessage(req).wait()
            }
        } catch {
            logger.error("failed to send BES event: \(error)")
        }
        // todo: don't force unwrap here
        return stream!.sendEnd()
    }

    private func createRequestsFor(build: BuildMetrics) -> Set<StreamReq> {
        let invocationId = UUID().uuidString
        let factory = BuildEventRequestFactory(
                buildId: build.build.id ?? "",
                invocationId: invocationId,
                logger: logger)

        return [
            // started event
            // todo: im actually not sure if the very first event should embed the bazel started event or not,
            // need to test against our server impl and see what happens; it shouldnt matter one way or the other iirc?
            factory.bazelEventRequest { ev, req in
                req.projectID = besConfig.projectId
                req.notificationKeywords = besConfig.keywords
                // populate the started event; set `id` and `payload`
                var id = BuildEventStream_BuildEventId()
                id.started = BuildEventStream_BuildEventId.BuildStartedId()
                ev.id = id
                var started = BuildEventStream_BuildStarted()
                started.uuid = invocationId
                started.startTimeMillis = Int64(build.build.startTimestampMicroseconds * 1000)
                // todo: more data for started. example:
                // started {
                //  uuid: "d5f5ab9c-39f0-4770-88db-ac6425815fef"
                //  start_time_millis: 1614305210847
                //  build_tool_version: "4.0.0"
                //  options_description: "--color=yes --show_timestamps --disk_cache=/tmp/bazel_disk_cache ..."
                //  command: "build"
                //  working_directory: "/Users/u/code/repos/r"
                //  workspace_directory: "/Users/u/code/repos/r"
                //  server_pid: 43829
                //}
                ev.payload = .started(started)

                // populate children Ids of the started event
                // bazel lists all the possible children here, some populated but most not.
                // don't think we need most of them, but this is where the "pattern" is set.
                // todo: something more useful for the pattern
                var syntheticPattern = "<xcodebuild>"
                var patternId = BuildEventStream_BuildEventId()
                patternId.pattern = BuildEventStream_BuildEventId.PatternExpandedId()
                patternId.pattern.pattern = [syntheticPattern]
                ev.children = [patternId]
            },

            // todo:
            // intermediate events (Bazel events)
            // probably want at least:
            // - unstructured_command_line
            // - configuration
            // - progress
            // - targetConfigured
            // - targetCompleted
            // - buildMetrics
            // - buildToolLogs
            // make use of:
            // factory.bazelEventRequest { ev, req in },

            // build stream finished event (end of bazel stream)
            factory.bazelEventRequest { ev, req in
                var id = BuildEventStream_BuildEventId()
                id.buildFinished = BuildEventStream_BuildEventId.BuildFinishedId()
                var finished = BuildEventStream_BuildFinished()
                var code = BuildEventStream_BuildFinished.ExitCode()
                if build.errors == nil || build.errors!.isEmpty {
                    finished.overallSuccess = true
                    code.name = "SUCCESS"
                    code.code = 0
                } else {
                    finished.overallSuccess = false
                    code.name = "FAILED"
                    code.code = 1
                }
                finished.finishTimeMillis = Int64(build.build.endTimestampMicroseconds * 1000)
                finished.exitCode = code
                ev.payload = .finished(finished)
            },
            // component stream finished event
            factory.newEventRequest { ev in
                ev.orderedBuildEvent.event.componentStreamFinished = finishedEvent { finished in }
            }
        ]
    }
}

private class BuildEventRequestFactory {
    var currentSequenceNumber: Int64 = 0
    let buildId: String
    let invocationId: String
    let logger: Logger

    init(buildId: String, invocationId: String, logger: Logger) {
        self.buildId = buildId
        self.invocationId = invocationId
        self.logger = logger
    }

    /**
     Boilerplate for metadata and stream state which all events should contain
     - Parameter f: the request instantiation closure
     - Returns: a stream request
     */
    func newEventRequest(f:(inout StreamReq) -> Void) -> StreamReq {
        currentSequenceNumber += 1
        var r = streamRequest { req in
            req.orderedBuildEvent = orderedBuildEvent {
                $0.streamID = streamId {
                    // todo: closer look at the buildId here based on what Bazel is doing
                    $0.buildID = buildId
                    $0.invocationID = UUID().uuidString
                }
                $0.sequenceNumber = currentSequenceNumber
            }
        }
        f(&r)
        return r
    }

    /**
     Boilerplate for the actual bazel events
     - Parameter f:
     - Returns:
     */
    func bazelEventRequest(f:(inout BuildEventStream_BuildEvent, inout StreamReq) -> Void) -> StreamReq {
        var bazelEvent = BuildEventStream_BuildEvent()
        var request: StreamReq = newEventRequest { req in
            req.orderedBuildEvent.event = buildEvent {
                do {
                    $0.bazelEvent = try SwiftProtobuf.Google_Protobuf_Any(message: bazelEvent)
                }
                catch {
                    logger.error("failed to cast bazel event to any: \(error)")
                }
            }
        }
        f(&bazelEvent, &request)
        return request
    }
}

func buildEvent(f:(inout Google_Devtools_Build_V1_BuildEvent) -> Void) -> Google_Devtools_Build_V1_BuildEvent {
    var t = Google_Devtools_Build_V1_BuildEvent()
    f(&t)
    return t
}

func finishedEvent(f:(inout Google_Devtools_Build_V1_BuildEvent.BuildComponentStreamFinished) -> Void) -> Google_Devtools_Build_V1_BuildEvent.BuildComponentStreamFinished {
    var t = Google_Devtools_Build_V1_BuildEvent.BuildComponentStreamFinished()
    f(&t)
    return t
}

func orderedBuildEvent(f:(inout Google_Devtools_Build_V1_OrderedBuildEvent) -> Void) -> Google_Devtools_Build_V1_OrderedBuildEvent {
    var t = Google_Devtools_Build_V1_OrderedBuildEvent()
    f(&t)
    return t
}

func streamId(f:(inout Google_Devtools_Build_V1_StreamId) -> Void) -> Google_Devtools_Build_V1_StreamId {
    var t = Google_Devtools_Build_V1_StreamId()
    f(&t)
    return t
}

func streamRequest(f:(inout StreamReq) -> Void) -> StreamReq {
    var t = StreamReq()
    f(&t)
    return t
}