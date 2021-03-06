// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: google/devtools/build/v1/build_status.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

/// Status used for both invocation attempt and overall build completion.
public struct Google_Devtools_Build_V1_BuildStatus {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The end result.
  public var result: Google_Devtools_Build_V1_BuildStatus.Result {
    get {return _storage._result}
    set {_uniqueStorage()._result = newValue}
  }

  /// Final invocation ID of the build, if there was one.
  /// This field is only set on a status in BuildFinished event.
  public var finalInvocationID: String {
    get {return _storage._finalInvocationID}
    set {_uniqueStorage()._finalInvocationID = newValue}
  }

  /// Build tool exit code. Integer value returned by the executed build tool.
  /// Might not be available in some cases, e.g., a build timeout.
  public var buildToolExitCode: SwiftProtobuf.Google_Protobuf_Int32Value {
    get {return _storage._buildToolExitCode ?? SwiftProtobuf.Google_Protobuf_Int32Value()}
    set {_uniqueStorage()._buildToolExitCode = newValue}
  }
  /// Returns true if `buildToolExitCode` has been explicitly set.
  public var hasBuildToolExitCode: Bool {return _storage._buildToolExitCode != nil}
  /// Clears the value of `buildToolExitCode`. Subsequent reads from it will return its default value.
  public mutating func clearBuildToolExitCode() {_uniqueStorage()._buildToolExitCode = nil}

  /// Fine-grained diagnostic information to complement the status.
  public var details: SwiftProtobuf.Google_Protobuf_Any {
    get {return _storage._details ?? SwiftProtobuf.Google_Protobuf_Any()}
    set {_uniqueStorage()._details = newValue}
  }
  /// Returns true if `details` has been explicitly set.
  public var hasDetails: Bool {return _storage._details != nil}
  /// Clears the value of `details`. Subsequent reads from it will return its default value.
  public mutating func clearDetails() {_uniqueStorage()._details = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  /// The end result of the Build.
  public enum Result: SwiftProtobuf.Enum {
    public typealias RawValue = Int

    /// Unspecified or unknown.
    case unknownStatus // = 0

    /// Build was successful and tests (if requested) all pass.
    case commandSucceeded // = 1

    /// Build error and/or test failure.
    case commandFailed // = 2

    /// Unable to obtain a result due to input provided by the user.
    case userError // = 3

    /// Unable to obtain a result due to a failure within the build system.
    case systemError // = 4

    /// Build required too many resources, such as build tool RAM.
    case resourceExhausted // = 5

    /// An invocation attempt time exceeded its deadline.
    case invocationDeadlineExceeded // = 6

    /// Build request time exceeded the request_deadline
    case requestDeadlineExceeded // = 8

    /// The build was cancelled by a call to CancelBuild.
    case cancelled // = 7
    case UNRECOGNIZED(Int)

    public init() {
      self = .unknownStatus
    }

    public init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .unknownStatus
      case 1: self = .commandSucceeded
      case 2: self = .commandFailed
      case 3: self = .userError
      case 4: self = .systemError
      case 5: self = .resourceExhausted
      case 6: self = .invocationDeadlineExceeded
      case 7: self = .cancelled
      case 8: self = .requestDeadlineExceeded
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    public var rawValue: Int {
      switch self {
      case .unknownStatus: return 0
      case .commandSucceeded: return 1
      case .commandFailed: return 2
      case .userError: return 3
      case .systemError: return 4
      case .resourceExhausted: return 5
      case .invocationDeadlineExceeded: return 6
      case .cancelled: return 7
      case .requestDeadlineExceeded: return 8
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  public init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

#if swift(>=4.2)

extension Google_Devtools_Build_V1_BuildStatus.Result: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [Google_Devtools_Build_V1_BuildStatus.Result] = [
    .unknownStatus,
    .commandSucceeded,
    .commandFailed,
    .userError,
    .systemError,
    .resourceExhausted,
    .invocationDeadlineExceeded,
    .requestDeadlineExceeded,
    .cancelled,
  ]
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "google.devtools.build.v1"

extension Google_Devtools_Build_V1_BuildStatus: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".BuildStatus"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "result"),
    3: .standard(proto: "final_invocation_id"),
    4: .standard(proto: "build_tool_exit_code"),
    2: .same(proto: "details"),
  ]

  fileprivate class _StorageClass {
    var _result: Google_Devtools_Build_V1_BuildStatus.Result = .unknownStatus
    var _finalInvocationID: String = String()
    var _buildToolExitCode: SwiftProtobuf.Google_Protobuf_Int32Value? = nil
    var _details: SwiftProtobuf.Google_Protobuf_Any? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _result = source._result
      _finalInvocationID = source._finalInvocationID
      _buildToolExitCode = source._buildToolExitCode
      _details = source._details
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
        case 1: try decoder.decodeSingularEnumField(value: &_storage._result)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._details)
        case 3: try decoder.decodeSingularStringField(value: &_storage._finalInvocationID)
        case 4: try decoder.decodeSingularMessageField(value: &_storage._buildToolExitCode)
        default: break
        }
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if _storage._result != .unknownStatus {
        try visitor.visitSingularEnumField(value: _storage._result, fieldNumber: 1)
      }
      if let v = _storage._details {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if !_storage._finalInvocationID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._finalInvocationID, fieldNumber: 3)
      }
      if let v = _storage._buildToolExitCode {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Google_Devtools_Build_V1_BuildStatus, rhs: Google_Devtools_Build_V1_BuildStatus) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._result != rhs_storage._result {return false}
        if _storage._finalInvocationID != rhs_storage._finalInvocationID {return false}
        if _storage._buildToolExitCode != rhs_storage._buildToolExitCode {return false}
        if _storage._details != rhs_storage._details {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Google_Devtools_Build_V1_BuildStatus.Result: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "UNKNOWN_STATUS"),
    1: .same(proto: "COMMAND_SUCCEEDED"),
    2: .same(proto: "COMMAND_FAILED"),
    3: .same(proto: "USER_ERROR"),
    4: .same(proto: "SYSTEM_ERROR"),
    5: .same(proto: "RESOURCE_EXHAUSTED"),
    6: .same(proto: "INVOCATION_DEADLINE_EXCEEDED"),
    7: .same(proto: "CANCELLED"),
    8: .same(proto: "REQUEST_DEADLINE_EXCEEDED"),
  ]
}
