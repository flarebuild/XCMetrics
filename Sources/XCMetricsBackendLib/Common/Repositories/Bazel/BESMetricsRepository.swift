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
    let besConfig: BESConfiguration
    let group = MultiThreadedEventLoopGroup(numberOfThreads: 4)

    init(logger: Logger, besConfig: BESConfiguration) {
        self.logger = logger
        self.besConfig = besConfig
    }

    /**
     Initializes a gRPC BES client
     - Parameter group:
     - Returns: the configured BESClient (Google_Devtools_Build_V1_PublishBuildEventServiceClient)
     */
    private func initClient(group: EventLoopGroup) -> BESClient? {
        let target: URLComponents
        if besConfig.target == nil {
            return .none
        } else {
            target = besConfig.target!
        }
        do {
            let secure: Bool = target.scheme != nil && target.scheme!.contains("grpcs")
            let ccc = ClientConnection.Configuration(
                    target: .hostAndPort(target.host!, target.port!),
                    eventLoopGroup: group,
                    tls:  secure ? ClientConnection.Configuration.TLS() : nil)
            let cc = ClientConnection(configuration: ccc)
            let hdrs = besConfig.authToken != nil ? [("x-api-key", besConfig.authToken!)] : []
            let co = CallOptions(customMetadata: HPACKHeaders(hdrs), timeout: try .seconds(5))
            return .some(BESClient(connection: cc, defaultCallOptions: co))
        } catch {
            logger.error("Error creating server connection: \(error)")
        }
        return .none
    }

    func insertBuildMetrics(_ buildMetrics: BuildMetrics, using eventLoop: EventLoop) -> EventLoopFuture<Void> {
        if let rawClient = initClient(group: group) {
            let requests = createRequestsFor(build: buildMetrics)
            let wrappedClient = WrappedClient(client: rawClient, eventLoop: eventLoop, requests: requests, logger: logger)
            let stream = wrappedClient.publishEventStream()
            return stream.sendMessages(requests)
                .flatMap { _ in stream.sendEnd() }
                .flatMap { _ in wrappedClient.done }
                .flatMap { _ in rawClient.connection.close() }
                .flatMapError { e in
                    logger.error("error: \(e.localizedDescription)")
                    return eventLoop.makeFailedFuture(e)
                }
        } else {
            logger.error("no grpc connection!")
            return eventLoop.makeFailedFuture(NSError(domain: "no_grpc_conn", code: 1))
        }
    }

    private func createRequestsFor(build: BuildMetrics) -> Array<StreamReq> {
        // use a simple UUID for the buildID field, but align `invocationId` with
        // the visibile `build.id` from xcmetrics for correlation
        let invocationId = build.build.id?.components(separatedBy: "_")[1] ?? UUID().uuidString
        let factory = BuildEventRequestFactory(
                buildId: UUID().uuidString,
                invocationId: invocationId,
                logger: logger)
        return [
            // started event
            factory.makeBazelEventRequest { ev, req in
                req.projectID = besConfig.projectId
                req.notificationKeywords = besConfig.keywords
                // populate the started event; set `id` and `payload`
                ev.id = make {
                    $0.started = make { startedId in }
                }
                ev.payload = .started(make {
                    $0.uuid = invocationId
                    $0.startTimeMillis = Int64(build.build.startTimestampMicroseconds * 1000)
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
                })

                // populate children Ids of the started event
                // bazel lists all the possible children here, some populated but most not.
                // don't think we need most of them, but this is where the "pattern" is set.
                ev.children = [make {
                    $0.pattern = make {
                        // todo: something more useful for the pattern
                        $0.pattern = ["<xcodebuild>"]
                    }
                }]
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
            factory.makeBazelEventRequest { ev, req in
                ev.id = make {
                    $0.buildFinished = BuildEventStream_BuildEventId.BuildFinishedId()
                }
                ev.payload = .finished(make { fin in
                    fin.finishTimeMillis = Int64(build.build.endTimestampMicroseconds * 1000)
                    fin.exitCode = make {
                        if build.errors == nil || build.errors!.isEmpty {
                            fin.overallSuccess = true
                            $0.name = "SUCCESS"
                            $0.code = 0
                        } else {
                            fin.overallSuccess = false
                            $0.name = "FAILED"
                            $0.code = 1
                        }
                    }
                })
            },
            // component stream finished event
            factory.makeEventRequest { ev in
                ev.orderedBuildEvent.event.componentStreamFinished = make { finished in }
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
    func makeEventRequest(f:(inout StreamReq) -> Void) -> StreamReq {
        currentSequenceNumber += 1
        var r: StreamReq = make { req in
            req.orderedBuildEvent = make {
                $0.streamID = make {
                    $0.buildID = buildId
                    $0.invocationID = invocationId
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
    func makeBazelEventRequest(f:(inout BuildEventStream_BuildEvent, inout StreamReq) -> Void) -> StreamReq {
        var bazelEvent = BuildEventStream_BuildEvent()
        var request: StreamReq = makeEventRequest { req in
            req.orderedBuildEvent.event = make {
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

/**
 proto initialization DSL
 - Parameter f: initializer function
 - Returns: the proto message with your changes applied
 */
func make<T: Message> (f: (inout T) -> Void) -> T { var t = T.init(); f(&t); return t }

/**
 * Wrapper around the gRPC client which coordinates waiting for server acks while leaving most of the rest of the
 * gRPC client interface intact
 */
private class WrappedClient {
    private let _done: EventLoopPromise<Void>
    private var queue: BuildEventResponseQueue
    private let client: BESClient
    private let logger: Logger

    var done: EventLoopFuture<Void> {
        get { _done.futureResult }
    }

    init(client: BESClient, eventLoop: EventLoop, requests: Array<StreamReq>, logger: Logger) {
        self.client = client
        self.logger = logger

        // initialize internal queue which drives the `done` future used to signal that all acks have been received
        _done = eventLoop.makePromise()
        queue = BuildEventResponseQueue.init()
        queue.onEmpty = { [weak self] () -> Void in
            self?._done.completeWith(eventLoop.future())
        }
        requests.forEach { queue.enqueue(el: $0.orderedBuildEvent.sequenceNumber) }
    }

    /**
     A wrapper over the gRPC client's publishBuildToolEventStream method which dequeues expected acks
      from the internal queue
     - Returns: A BidirectionalStreamingCall
     */
    func publishEventStream() -> StreamCall {
        client.publishBuildToolEventStream(handler: { ack in
            if let expected = self.queue.dequeue() {
                self.logger.debug("BES Server ack: \(ack)")
                assert(expected == ack.sequenceNumber)
            } else {
                self.logger.warning("warn: bad ack")
            }
        })
    }

    /**
     * A simple queue of expected sequence numbers which invokes the supplied isEmpty closure when drained
     */
    private struct BuildEventResponseQueue {
        var onEmpty: (() -> Void)? = nil
        var items: [Int64] = []
        mutating func enqueue(el: Int64) {
            items.append(el)
        }
        mutating func dequeue() -> Int64? {
            if items.isEmpty {
                return nil
            }
            let tmp = items.first
            items.remove(at: 0)
            if items.isEmpty { onEmpty?() }
            return tmp
        }
    }
}