// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: src/main/protobuf/worker_protocol.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

// Copyright 2015 The Bazel Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
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

/// An input file.
public struct Blaze_Worker_Input {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The path in the file system where to read this input artifact from. This is
  /// either a path relative to the execution root (the worker process is
  /// launched with the working directory set to the execution root), or an
  /// absolute path.
  public var path: String = String()

  /// A hash-value of the contents. The format of the contents is unspecified and
  /// the digest should be treated as an opaque token.
  public var digest: Data = SwiftProtobuf.Internal.emptyData

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// This represents a single work unit that Blaze sends to the worker.
public struct Blaze_Worker_WorkRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var arguments: [String] = []

  /// The inputs that the worker is allowed to read during execution of this
  /// request.
  public var inputs: [Blaze_Worker_Input] = []

  /// To support multiplex worker, each WorkRequest must have an unique ID. This
  /// ID should be attached unchanged to the WorkResponse.
  public var requestID: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// The worker sends this message to Blaze when it finished its work on the
/// WorkRequest message.
public struct Blaze_Worker_WorkResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var exitCode: Int32 = 0

  /// This is printed to the user after the WorkResponse has been received and is
  /// supposed to contain compiler warnings / errors etc. - thus we'll use a
  /// string type here, which gives us UTF-8 encoding.
  public var output: String = String()

  /// To support multiplex worker, each WorkResponse must have an unique ID.
  /// Since worker processes which support multiplex worker will handle multiple
  /// WorkRequests in parallel, this ID will be used to determined which
  /// WorkerProxy does this WorkResponse belong to.
  public var requestID: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "blaze.worker"

extension Blaze_Worker_Input: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Input"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "path"),
    2: .same(proto: "digest"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.path)
      case 2: try decoder.decodeSingularBytesField(value: &self.digest)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.path.isEmpty {
      try visitor.visitSingularStringField(value: self.path, fieldNumber: 1)
    }
    if !self.digest.isEmpty {
      try visitor.visitSingularBytesField(value: self.digest, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Blaze_Worker_Input, rhs: Blaze_Worker_Input) -> Bool {
    if lhs.path != rhs.path {return false}
    if lhs.digest != rhs.digest {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Blaze_Worker_WorkRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".WorkRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "arguments"),
    2: .same(proto: "inputs"),
    3: .standard(proto: "request_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedStringField(value: &self.arguments)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.inputs)
      case 3: try decoder.decodeSingularInt32Field(value: &self.requestID)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.arguments.isEmpty {
      try visitor.visitRepeatedStringField(value: self.arguments, fieldNumber: 1)
    }
    if !self.inputs.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.inputs, fieldNumber: 2)
    }
    if self.requestID != 0 {
      try visitor.visitSingularInt32Field(value: self.requestID, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Blaze_Worker_WorkRequest, rhs: Blaze_Worker_WorkRequest) -> Bool {
    if lhs.arguments != rhs.arguments {return false}
    if lhs.inputs != rhs.inputs {return false}
    if lhs.requestID != rhs.requestID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Blaze_Worker_WorkResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".WorkResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "exit_code"),
    2: .same(proto: "output"),
    3: .standard(proto: "request_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt32Field(value: &self.exitCode)
      case 2: try decoder.decodeSingularStringField(value: &self.output)
      case 3: try decoder.decodeSingularInt32Field(value: &self.requestID)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.exitCode != 0 {
      try visitor.visitSingularInt32Field(value: self.exitCode, fieldNumber: 1)
    }
    if !self.output.isEmpty {
      try visitor.visitSingularStringField(value: self.output, fieldNumber: 2)
    }
    if self.requestID != 0 {
      try visitor.visitSingularInt32Field(value: self.requestID, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Blaze_Worker_WorkResponse, rhs: Blaze_Worker_WorkResponse) -> Bool {
    if lhs.exitCode != rhs.exitCode {return false}
    if lhs.output != rhs.output {return false}
    if lhs.requestID != rhs.requestID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}