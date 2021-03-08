// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: src/main/protobuf/command_server.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

/// Copyright 2016 The Bazel Authors. All rights reserved.
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// This file contains the protocol used to communicate between the Bazel client
/// and the server. At a high level clients may call the CommandServer.run rpc
/// to initiates a Bazel command and CommandServer.cancel to cancel an in-flight
/// command. CommandServer.ping may be used to check for server liveness without
/// executing any commands. See documentation of individual messages for more
/// details.

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// Passed to CommandServer.run to initiate execution of a Bazel command.
public struct CommandServer_RunRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Request cookie from the output base of the server. This serves as a
  /// rudimentary form of mutual authentication.
  public var cookie: String = String()

  /// Command and command arguments. Does not include startup arguments.
  public var arg: [Data] = []

  /// Tells the server whether or not the client is willing to wait for any
  /// concurrent in-flight request to complete (there are many commands which
  /// may not run concurrently). If false and there are in-flight requests then
  /// the server will return an error immediately.
  public var blockForLock: Bool = false

  /// A simple description of the client for reporting purposes. This value is
  /// required.
  public var clientDescription: String = String()

  /// Invocation policy affects how command arguments are interpreted and should
  /// be passed separately. This is a proto message, either a human readable
  /// String or base64-encoded binary-serialized version of the message. It is
  /// not typed directly as an InvocationPolicy message due to distinctions
  /// between batch and server mode, so the parsing logic is only in the Java
  /// code.
  public var invocationPolicy: String = String()

  /// Startup arguments, in the order they were applied, tagged with where they
  /// came from. These options have already been parsed and already have had
  /// their effect. This information should only be used for logging.
  public var startupOptions: [CommandServer_StartupOption] = []

  /// Whether the resulting command can be preempted if additional commands
  /// are received.
  public var preemptible: Bool = false

  /// Additional per-command information passed to the server in the form of
  /// arbitrary messages which the server may be programmed to recognize and
  /// consume. Unrecognized message types are ignored.
  public var commandExtensions: [SwiftProtobuf.Google_Protobuf_Any] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Contains the a startup option with its source file. Uses bytes to preserve
/// the way the user inputted the arguments, like the args in RunRequest.
public struct CommandServer_StartupOption {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Startup option in --nullaryflag or --unaryflag=value form.
  public var option: Data = SwiftProtobuf.Internal.emptyData

  /// Where the option came from, such as an rc file or an empty string for the
  /// command line.
  public var source: Data = SwiftProtobuf.Internal.emptyData

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Description of an environment variable
public struct CommandServer_EnvironmentVariable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var name: Data = SwiftProtobuf.Internal.emptyData

  public var value: Data = SwiftProtobuf.Internal.emptyData

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Description of a request by the server to the client to execute a binary
/// after the command invocation finishes.
public struct CommandServer_ExecRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var workingDirectory: Data = SwiftProtobuf.Internal.emptyData

  public var argv: [Data] = []

  public var environmentVariable: [CommandServer_EnvironmentVariable] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Contains metadata and result data for a command execution.
public struct CommandServer_RunResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Request cookie from the output base of the server. This serves as a
  /// rudimentary form of mutual authentication. Set on every response.
  public var cookie: String {
    get {return _storage._cookie}
    set {_uniqueStorage()._cookie = newValue}
  }

  /// Standard out of the command, chunked. May be empty.
  public var standardOutput: Data {
    get {return _storage._standardOutput}
    set {_uniqueStorage()._standardOutput = newValue}
  }

  /// Standard error of the command, chunked. May be empty.
  public var standardError: Data {
    get {return _storage._standardError}
    set {_uniqueStorage()._standardError = newValue}
  }

  /// Whether this is the last message of the stream, signals that exit_code is
  /// valid.
  public var finished: Bool {
    get {return _storage._finished}
    set {_uniqueStorage()._finished = newValue}
  }

  /// The exit code of the command, only valid when finished is set.
  public var exitCode: Int32 {
    get {return _storage._exitCode}
    set {_uniqueStorage()._exitCode = newValue}
  }

  /// Randomly generated command identifier, this may be used to cancel execution
  /// of the command by issuing a cancel call. This should be sent to the client
  /// as soon as possible. This is not required to be set (non-empty) on every
  /// response.
  public var commandID: String {
    get {return _storage._commandID}
    set {_uniqueStorage()._commandID = newValue}
  }

  /// Whether the command has shut down the server; if set, the client should
  /// wait until the server process dies before finishing.
  public var terminationExpected: Bool {
    get {return _storage._terminationExpected}
    set {_uniqueStorage()._terminationExpected = newValue}
  }

  /// A command to exec() after the command invocation finishes. Should only be
  /// present if finished is set.
  public var execRequest: CommandServer_ExecRequest {
    get {return _storage._execRequest ?? CommandServer_ExecRequest()}
    set {_uniqueStorage()._execRequest = newValue}
  }
  /// Returns true if `execRequest` has been explicitly set.
  public var hasExecRequest: Bool {return _storage._execRequest != nil}
  /// Clears the value of `execRequest`. Subsequent reads from it will return its default value.
  public mutating func clearExecRequest() {_uniqueStorage()._execRequest = nil}

  /// Fine-grained failure details. Should only be present if finished is set.
  /// WARNING: This functionality is experimental and should not be relied on at
  /// this time.
  /// TODO(mschaller): remove experimental warning
  public var failureDetail: FailureDetails_FailureDetail {
    get {return _storage._failureDetail ?? FailureDetails_FailureDetail()}
    set {_uniqueStorage()._failureDetail = newValue}
  }
  /// Returns true if `failureDetail` has been explicitly set.
  public var hasFailureDetail: Bool {return _storage._failureDetail != nil}
  /// Clears the value of `failureDetail`. Subsequent reads from it will return its default value.
  public mutating func clearFailureDetail() {_uniqueStorage()._failureDetail = nil}

  /// Additional per-command information passed by the server in the form of
  /// arbitrary messages.
  public var commandExtensions: [SwiftProtobuf.Google_Protobuf_Any] {
    get {return _storage._commandExtensions}
    set {_uniqueStorage()._commandExtensions = newValue}
  }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// Passed to CommandServer.cancel to initiate graceful cancellation of an
/// in-flight command.
public struct CommandServer_CancelRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The client request cookie (see RunRequest.cookie).
  public var cookie: String = String()

  /// The id of the command to cancel.
  public var commandID: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct CommandServer_CancelResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The server response cookie (see RunResponse.cookie).
  public var cookie: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Passed to CommandServer.ping to initiate a ping request.
public struct CommandServer_PingRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The client request cookie (see RunRequest.cookie).
  public var cookie: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct CommandServer_PingResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The server response cookie (see RunResponse.cookie).
  public var cookie: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Describes metadata necessary for connecting to and managing the server.
public struct CommandServer_ServerInfo {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The server process's pid.
  public var pid: Int32 = 0

  /// Address the CommandServer is listening on. Can be passed directly to grpc
  /// to create a connection.
  public var address: String = String()

  /// Client request cookie.
  public var requestCookie: String = String()

  /// Server response cookie.
  public var responseCookie: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "command_server"

extension CommandServer_RunRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".RunRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cookie"),
    2: .same(proto: "arg"),
    3: .standard(proto: "block_for_lock"),
    4: .standard(proto: "client_description"),
    5: .standard(proto: "invocation_policy"),
    6: .standard(proto: "startup_options"),
    7: .same(proto: "preemptible"),
    8: .standard(proto: "command_extensions"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.cookie)
      case 2: try decoder.decodeRepeatedBytesField(value: &self.arg)
      case 3: try decoder.decodeSingularBoolField(value: &self.blockForLock)
      case 4: try decoder.decodeSingularStringField(value: &self.clientDescription)
      case 5: try decoder.decodeSingularStringField(value: &self.invocationPolicy)
      case 6: try decoder.decodeRepeatedMessageField(value: &self.startupOptions)
      case 7: try decoder.decodeSingularBoolField(value: &self.preemptible)
      case 8: try decoder.decodeRepeatedMessageField(value: &self.commandExtensions)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.cookie.isEmpty {
      try visitor.visitSingularStringField(value: self.cookie, fieldNumber: 1)
    }
    if !self.arg.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.arg, fieldNumber: 2)
    }
    if self.blockForLock != false {
      try visitor.visitSingularBoolField(value: self.blockForLock, fieldNumber: 3)
    }
    if !self.clientDescription.isEmpty {
      try visitor.visitSingularStringField(value: self.clientDescription, fieldNumber: 4)
    }
    if !self.invocationPolicy.isEmpty {
      try visitor.visitSingularStringField(value: self.invocationPolicy, fieldNumber: 5)
    }
    if !self.startupOptions.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.startupOptions, fieldNumber: 6)
    }
    if self.preemptible != false {
      try visitor.visitSingularBoolField(value: self.preemptible, fieldNumber: 7)
    }
    if !self.commandExtensions.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.commandExtensions, fieldNumber: 8)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_RunRequest, rhs: CommandServer_RunRequest) -> Bool {
    if lhs.cookie != rhs.cookie {return false}
    if lhs.arg != rhs.arg {return false}
    if lhs.blockForLock != rhs.blockForLock {return false}
    if lhs.clientDescription != rhs.clientDescription {return false}
    if lhs.invocationPolicy != rhs.invocationPolicy {return false}
    if lhs.startupOptions != rhs.startupOptions {return false}
    if lhs.preemptible != rhs.preemptible {return false}
    if lhs.commandExtensions != rhs.commandExtensions {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_StartupOption: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".StartupOption"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "option"),
    2: .same(proto: "source"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.option)
      case 2: try decoder.decodeSingularBytesField(value: &self.source)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.option.isEmpty {
      try visitor.visitSingularBytesField(value: self.option, fieldNumber: 1)
    }
    if !self.source.isEmpty {
      try visitor.visitSingularBytesField(value: self.source, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_StartupOption, rhs: CommandServer_StartupOption) -> Bool {
    if lhs.option != rhs.option {return false}
    if lhs.source != rhs.source {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_EnvironmentVariable: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".EnvironmentVariable"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "value"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.name)
      case 2: try decoder.decodeSingularBytesField(value: &self.value)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularBytesField(value: self.name, fieldNumber: 1)
    }
    if !self.value.isEmpty {
      try visitor.visitSingularBytesField(value: self.value, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_EnvironmentVariable, rhs: CommandServer_EnvironmentVariable) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_ExecRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ExecRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "working_directory"),
    2: .same(proto: "argv"),
    3: .standard(proto: "environment_variable"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.workingDirectory)
      case 2: try decoder.decodeRepeatedBytesField(value: &self.argv)
      case 3: try decoder.decodeRepeatedMessageField(value: &self.environmentVariable)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.workingDirectory.isEmpty {
      try visitor.visitSingularBytesField(value: self.workingDirectory, fieldNumber: 1)
    }
    if !self.argv.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.argv, fieldNumber: 2)
    }
    if !self.environmentVariable.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.environmentVariable, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_ExecRequest, rhs: CommandServer_ExecRequest) -> Bool {
    if lhs.workingDirectory != rhs.workingDirectory {return false}
    if lhs.argv != rhs.argv {return false}
    if lhs.environmentVariable != rhs.environmentVariable {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_RunResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".RunResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cookie"),
    2: .standard(proto: "standard_output"),
    3: .standard(proto: "standard_error"),
    4: .same(proto: "finished"),
    5: .standard(proto: "exit_code"),
    6: .standard(proto: "command_id"),
    7: .standard(proto: "termination_expected"),
    8: .standard(proto: "exec_request"),
    9: .standard(proto: "failure_detail"),
    10: .standard(proto: "command_extensions"),
  ]

  fileprivate class _StorageClass {
    var _cookie: String = String()
    var _standardOutput: Data = SwiftProtobuf.Internal.emptyData
    var _standardError: Data = SwiftProtobuf.Internal.emptyData
    var _finished: Bool = false
    var _exitCode: Int32 = 0
    var _commandID: String = String()
    var _terminationExpected: Bool = false
    var _execRequest: CommandServer_ExecRequest? = nil
    var _failureDetail: FailureDetails_FailureDetail? = nil
    var _commandExtensions: [SwiftProtobuf.Google_Protobuf_Any] = []

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _cookie = source._cookie
      _standardOutput = source._standardOutput
      _standardError = source._standardError
      _finished = source._finished
      _exitCode = source._exitCode
      _commandID = source._commandID
      _terminationExpected = source._terminationExpected
      _execRequest = source._execRequest
      _failureDetail = source._failureDetail
      _commandExtensions = source._commandExtensions
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularStringField(value: &_storage._cookie)
        case 2: try decoder.decodeSingularBytesField(value: &_storage._standardOutput)
        case 3: try decoder.decodeSingularBytesField(value: &_storage._standardError)
        case 4: try decoder.decodeSingularBoolField(value: &_storage._finished)
        case 5: try decoder.decodeSingularInt32Field(value: &_storage._exitCode)
        case 6: try decoder.decodeSingularStringField(value: &_storage._commandID)
        case 7: try decoder.decodeSingularBoolField(value: &_storage._terminationExpected)
        case 8: try decoder.decodeSingularMessageField(value: &_storage._execRequest)
        case 9: try decoder.decodeSingularMessageField(value: &_storage._failureDetail)
        case 10: try decoder.decodeRepeatedMessageField(value: &_storage._commandExtensions)
        default: break
        }
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._cookie.isEmpty {
        try visitor.visitSingularStringField(value: _storage._cookie, fieldNumber: 1)
      }
      if !_storage._standardOutput.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._standardOutput, fieldNumber: 2)
      }
      if !_storage._standardError.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._standardError, fieldNumber: 3)
      }
      if _storage._finished != false {
        try visitor.visitSingularBoolField(value: _storage._finished, fieldNumber: 4)
      }
      if _storage._exitCode != 0 {
        try visitor.visitSingularInt32Field(value: _storage._exitCode, fieldNumber: 5)
      }
      if !_storage._commandID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._commandID, fieldNumber: 6)
      }
      if _storage._terminationExpected != false {
        try visitor.visitSingularBoolField(value: _storage._terminationExpected, fieldNumber: 7)
      }
      if let v = _storage._execRequest {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 8)
      }
      if let v = _storage._failureDetail {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 9)
      }
      if !_storage._commandExtensions.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._commandExtensions, fieldNumber: 10)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_RunResponse, rhs: CommandServer_RunResponse) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._cookie != rhs_storage._cookie {return false}
        if _storage._standardOutput != rhs_storage._standardOutput {return false}
        if _storage._standardError != rhs_storage._standardError {return false}
        if _storage._finished != rhs_storage._finished {return false}
        if _storage._exitCode != rhs_storage._exitCode {return false}
        if _storage._commandID != rhs_storage._commandID {return false}
        if _storage._terminationExpected != rhs_storage._terminationExpected {return false}
        if _storage._execRequest != rhs_storage._execRequest {return false}
        if _storage._failureDetail != rhs_storage._failureDetail {return false}
        if _storage._commandExtensions != rhs_storage._commandExtensions {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_CancelRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".CancelRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cookie"),
    2: .standard(proto: "command_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.cookie)
      case 2: try decoder.decodeSingularStringField(value: &self.commandID)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.cookie.isEmpty {
      try visitor.visitSingularStringField(value: self.cookie, fieldNumber: 1)
    }
    if !self.commandID.isEmpty {
      try visitor.visitSingularStringField(value: self.commandID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_CancelRequest, rhs: CommandServer_CancelRequest) -> Bool {
    if lhs.cookie != rhs.cookie {return false}
    if lhs.commandID != rhs.commandID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_CancelResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".CancelResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cookie"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.cookie)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.cookie.isEmpty {
      try visitor.visitSingularStringField(value: self.cookie, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_CancelResponse, rhs: CommandServer_CancelResponse) -> Bool {
    if lhs.cookie != rhs.cookie {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_PingRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".PingRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cookie"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.cookie)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.cookie.isEmpty {
      try visitor.visitSingularStringField(value: self.cookie, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_PingRequest, rhs: CommandServer_PingRequest) -> Bool {
    if lhs.cookie != rhs.cookie {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_PingResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".PingResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cookie"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.cookie)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.cookie.isEmpty {
      try visitor.visitSingularStringField(value: self.cookie, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_PingResponse, rhs: CommandServer_PingResponse) -> Bool {
    if lhs.cookie != rhs.cookie {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommandServer_ServerInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ServerInfo"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "pid"),
    2: .same(proto: "address"),
    3: .standard(proto: "request_cookie"),
    4: .standard(proto: "response_cookie"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt32Field(value: &self.pid)
      case 2: try decoder.decodeSingularStringField(value: &self.address)
      case 3: try decoder.decodeSingularStringField(value: &self.requestCookie)
      case 4: try decoder.decodeSingularStringField(value: &self.responseCookie)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.pid != 0 {
      try visitor.visitSingularInt32Field(value: self.pid, fieldNumber: 1)
    }
    if !self.address.isEmpty {
      try visitor.visitSingularStringField(value: self.address, fieldNumber: 2)
    }
    if !self.requestCookie.isEmpty {
      try visitor.visitSingularStringField(value: self.requestCookie, fieldNumber: 3)
    }
    if !self.responseCookie.isEmpty {
      try visitor.visitSingularStringField(value: self.responseCookie, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommandServer_ServerInfo, rhs: CommandServer_ServerInfo) -> Bool {
    if lhs.pid != rhs.pid {return false}
    if lhs.address != rhs.address {return false}
    if lhs.requestCookie != rhs.requestCookie {return false}
    if lhs.responseCookie != rhs.responseCookie {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}