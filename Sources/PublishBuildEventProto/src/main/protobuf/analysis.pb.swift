// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: src/main/protobuf/analysis.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

// Copyright 2018 The Bazel Authors. All rights reserved.
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

/// Container for the action graph properties.
public struct Analysis_ActionGraphContainer {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var artifacts: [Analysis_Artifact] = []

  public var actions: [Analysis_Action] = []

  public var targets: [Analysis_Target] = []

  public var depSetOfFiles: [Analysis_DepSetOfFiles] = []

  public var configuration: [Analysis_Configuration] = []

  public var aspectDescriptors: [Analysis_AspectDescriptor] = []

  public var ruleClasses: [Analysis_RuleClass] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Represents a single artifact, whether it's a source file or a derived output
/// file.
public struct Analysis_Artifact {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Identifier for this artifact; this is an opaque string, only valid for this
  /// particular dump of the analysis.
  public var id: String = String()

  /// The relative path of the file within the execution root.
  public var execPath: String = String()

  /// True iff the artifact is a tree artifact, i.e. the above exec_path refers
  /// a directory.
  public var isTreeArtifact: Bool = false

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Represents a single action, which is a function from Artifact(s) to
/// Artifact(s).
public struct Analysis_Action {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The target that was responsible for the creation of the action.
  public var targetID: String = String()

  /// The aspects that were responsible for the creation of the action (if any).
  /// In the case of aspect-on-aspect, AspectDescriptors are listed in
  /// topological order of the dependency graph.
  /// e.g. [A, B] would imply that aspect A is applied on top of aspect B.
  public var aspectDescriptorIds: [String] = []

  /// Encodes all significant behavior that might affect the output. The key
  /// must change if the work performed by the execution of this action changes.
  /// Note that the key doesn't include checksums of the input files.
  public var actionKey: String = String()

  /// The mnemonic for this kind of action.
  public var mnemonic: String = String()

  /// The configuration under which this action is executed.
  public var configurationID: String = String()

  /// The command line arguments of the action. This will be only set if
  /// explicitly requested.
  public var arguments: [String] = []

  /// The list of environment variables to be set before executing the command.
  public var environmentVariables: [Analysis_KeyValuePair] = []

  /// The set of input dep sets that the action depends upon. If the action does
  /// input discovery, the contents of this set might change during execution.
  public var inputDepSetIds: [String] = []

  /// The list of Artifact IDs that represent the output files that this action
  /// will generate.
  public var outputIds: [String] = []

  /// True iff the action does input discovery during execution.
  public var discoversInputs: Bool = false

  /// Execution info for the action.  Remote execution services may use this
  /// information to modify the execution environment, but actions will
  /// generally not be aware of it.
  public var executionInfo: [Analysis_KeyValuePair] = []

  /// The list of param files. This will be only set if explicitly requested.
  public var paramFiles: [Analysis_ParamFile] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Represents a single target (without configuration information) that is
/// associated with an action.
public struct Analysis_Target {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Identifier for this target; this is an opaque string, only valid for this
  /// particular dump of the analysis.
  public var id: String = String()

  /// Label of the target, e.g. //foo:bar.
  public var label: String = String()

  /// Class of the rule.
  public var ruleClassID: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Analysis_RuleClass {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Identifier for this rule class; this is an opaque string, only valid for
  /// this particular dump of the analysis.
  public var id: String = String()

  /// Name of the rule class, e.g. cc_library.
  public var name: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Represents an invocation specific descriptor of an aspect.
public struct Analysis_AspectDescriptor {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Identifier for this aspect descriptor; this is an opaque string, only valid
  /// for the particular dump of the analysis.
  public var id: String = String()

  /// The name of the corresponding aspect. For native aspects, it's the Java
  /// class name, for Starlark aspects it's the bzl file followed by a % sign
  /// followed by the name of the aspect.
  public var name: String = String()

  /// The list of parameters bound to a particular invocation of that aspect on
  /// a target. Note that aspects can be executed multiple times on the same
  /// target in different order.
  public var parameters: [Analysis_KeyValuePair] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Analysis_DepSetOfFiles {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Identifier for this named set of files; this is an opaque string, only
  /// valid for the particular dump of the analysis.
  public var id: String = String()

  /// Other transitively included named set of files.
  public var transitiveDepSetIds: [String] = []

  /// The list of input artifact IDs that are immediately contained in this set.
  public var directArtifactIds: [String] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Analysis_Configuration {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Identifier for this configuration; this is an opaque string, only valid for
  /// the particular dump of the analysis.
  public var id: String = String()

  /// The mnemonic representing the build configuration.
  public var mnemonic: String = String()

  /// The platform string.
  public var platformName: String = String()

  /// The checksum representation of the configuration options;
  public var checksum: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Analysis_KeyValuePair {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The variable name.
  public var key: String = String()

  /// The variable value.
  public var value: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Analysis_ConfiguredTarget {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The target. We use blaze_query.Target defined in build.proto instead of
  /// the Target defined in this file because blaze_query.Target is much heavier
  /// and will output proto results similar to what users are familiar with from
  /// regular blaze query.
  public var target: BlazeQuery_Target {
    get {return _storage._target ?? BlazeQuery_Target()}
    set {_uniqueStorage()._target = newValue}
  }
  /// Returns true if `target` has been explicitly set.
  public var hasTarget: Bool {return _storage._target != nil}
  /// Clears the value of `target`. Subsequent reads from it will return its default value.
  public mutating func clearTarget() {_uniqueStorage()._target = nil}

  /// The configuration
  public var configuration: Analysis_Configuration {
    get {return _storage._configuration ?? Analysis_Configuration()}
    set {_uniqueStorage()._configuration = newValue}
  }
  /// Returns true if `configuration` has been explicitly set.
  public var hasConfiguration: Bool {return _storage._configuration != nil}
  /// Clears the value of `configuration`. Subsequent reads from it will return its default value.
  public mutating func clearConfiguration() {_uniqueStorage()._configuration = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// Container for cquery results
public struct Analysis_CqueryResult {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// All the configuredtargets returns by cquery
  public var results: [Analysis_ConfiguredTarget] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Content of a param file.
public struct Analysis_ParamFile {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The exec path of the param file artifact.
  public var execPath: String = String()

  /// The arguments in the param file.
  /// Each argument corresponds to a line in the param file.
  public var arguments: [String] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "analysis"

extension Analysis_ActionGraphContainer: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ActionGraphContainer"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "artifacts"),
    2: .same(proto: "actions"),
    3: .same(proto: "targets"),
    4: .standard(proto: "dep_set_of_files"),
    5: .same(proto: "configuration"),
    6: .standard(proto: "aspect_descriptors"),
    7: .standard(proto: "rule_classes"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.artifacts)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.actions)
      case 3: try decoder.decodeRepeatedMessageField(value: &self.targets)
      case 4: try decoder.decodeRepeatedMessageField(value: &self.depSetOfFiles)
      case 5: try decoder.decodeRepeatedMessageField(value: &self.configuration)
      case 6: try decoder.decodeRepeatedMessageField(value: &self.aspectDescriptors)
      case 7: try decoder.decodeRepeatedMessageField(value: &self.ruleClasses)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.artifacts.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.artifacts, fieldNumber: 1)
    }
    if !self.actions.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.actions, fieldNumber: 2)
    }
    if !self.targets.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.targets, fieldNumber: 3)
    }
    if !self.depSetOfFiles.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.depSetOfFiles, fieldNumber: 4)
    }
    if !self.configuration.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.configuration, fieldNumber: 5)
    }
    if !self.aspectDescriptors.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.aspectDescriptors, fieldNumber: 6)
    }
    if !self.ruleClasses.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.ruleClasses, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_ActionGraphContainer, rhs: Analysis_ActionGraphContainer) -> Bool {
    if lhs.artifacts != rhs.artifacts {return false}
    if lhs.actions != rhs.actions {return false}
    if lhs.targets != rhs.targets {return false}
    if lhs.depSetOfFiles != rhs.depSetOfFiles {return false}
    if lhs.configuration != rhs.configuration {return false}
    if lhs.aspectDescriptors != rhs.aspectDescriptors {return false}
    if lhs.ruleClasses != rhs.ruleClasses {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_Artifact: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Artifact"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .standard(proto: "exec_path"),
    3: .standard(proto: "is_tree_artifact"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.id)
      case 2: try decoder.decodeSingularStringField(value: &self.execPath)
      case 3: try decoder.decodeSingularBoolField(value: &self.isTreeArtifact)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.execPath.isEmpty {
      try visitor.visitSingularStringField(value: self.execPath, fieldNumber: 2)
    }
    if self.isTreeArtifact != false {
      try visitor.visitSingularBoolField(value: self.isTreeArtifact, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_Artifact, rhs: Analysis_Artifact) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.execPath != rhs.execPath {return false}
    if lhs.isTreeArtifact != rhs.isTreeArtifact {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_Action: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Action"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "target_id"),
    2: .standard(proto: "aspect_descriptor_ids"),
    3: .standard(proto: "action_key"),
    4: .same(proto: "mnemonic"),
    5: .standard(proto: "configuration_id"),
    6: .same(proto: "arguments"),
    7: .standard(proto: "environment_variables"),
    8: .standard(proto: "input_dep_set_ids"),
    9: .standard(proto: "output_ids"),
    10: .standard(proto: "discovers_inputs"),
    11: .standard(proto: "execution_info"),
    12: .standard(proto: "param_files"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.targetID)
      case 2: try decoder.decodeRepeatedStringField(value: &self.aspectDescriptorIds)
      case 3: try decoder.decodeSingularStringField(value: &self.actionKey)
      case 4: try decoder.decodeSingularStringField(value: &self.mnemonic)
      case 5: try decoder.decodeSingularStringField(value: &self.configurationID)
      case 6: try decoder.decodeRepeatedStringField(value: &self.arguments)
      case 7: try decoder.decodeRepeatedMessageField(value: &self.environmentVariables)
      case 8: try decoder.decodeRepeatedStringField(value: &self.inputDepSetIds)
      case 9: try decoder.decodeRepeatedStringField(value: &self.outputIds)
      case 10: try decoder.decodeSingularBoolField(value: &self.discoversInputs)
      case 11: try decoder.decodeRepeatedMessageField(value: &self.executionInfo)
      case 12: try decoder.decodeRepeatedMessageField(value: &self.paramFiles)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.targetID.isEmpty {
      try visitor.visitSingularStringField(value: self.targetID, fieldNumber: 1)
    }
    if !self.aspectDescriptorIds.isEmpty {
      try visitor.visitRepeatedStringField(value: self.aspectDescriptorIds, fieldNumber: 2)
    }
    if !self.actionKey.isEmpty {
      try visitor.visitSingularStringField(value: self.actionKey, fieldNumber: 3)
    }
    if !self.mnemonic.isEmpty {
      try visitor.visitSingularStringField(value: self.mnemonic, fieldNumber: 4)
    }
    if !self.configurationID.isEmpty {
      try visitor.visitSingularStringField(value: self.configurationID, fieldNumber: 5)
    }
    if !self.arguments.isEmpty {
      try visitor.visitRepeatedStringField(value: self.arguments, fieldNumber: 6)
    }
    if !self.environmentVariables.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.environmentVariables, fieldNumber: 7)
    }
    if !self.inputDepSetIds.isEmpty {
      try visitor.visitRepeatedStringField(value: self.inputDepSetIds, fieldNumber: 8)
    }
    if !self.outputIds.isEmpty {
      try visitor.visitRepeatedStringField(value: self.outputIds, fieldNumber: 9)
    }
    if self.discoversInputs != false {
      try visitor.visitSingularBoolField(value: self.discoversInputs, fieldNumber: 10)
    }
    if !self.executionInfo.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.executionInfo, fieldNumber: 11)
    }
    if !self.paramFiles.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.paramFiles, fieldNumber: 12)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_Action, rhs: Analysis_Action) -> Bool {
    if lhs.targetID != rhs.targetID {return false}
    if lhs.aspectDescriptorIds != rhs.aspectDescriptorIds {return false}
    if lhs.actionKey != rhs.actionKey {return false}
    if lhs.mnemonic != rhs.mnemonic {return false}
    if lhs.configurationID != rhs.configurationID {return false}
    if lhs.arguments != rhs.arguments {return false}
    if lhs.environmentVariables != rhs.environmentVariables {return false}
    if lhs.inputDepSetIds != rhs.inputDepSetIds {return false}
    if lhs.outputIds != rhs.outputIds {return false}
    if lhs.discoversInputs != rhs.discoversInputs {return false}
    if lhs.executionInfo != rhs.executionInfo {return false}
    if lhs.paramFiles != rhs.paramFiles {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_Target: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Target"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "label"),
    3: .standard(proto: "rule_class_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.id)
      case 2: try decoder.decodeSingularStringField(value: &self.label)
      case 3: try decoder.decodeSingularStringField(value: &self.ruleClassID)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.label.isEmpty {
      try visitor.visitSingularStringField(value: self.label, fieldNumber: 2)
    }
    if !self.ruleClassID.isEmpty {
      try visitor.visitSingularStringField(value: self.ruleClassID, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_Target, rhs: Analysis_Target) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.label != rhs.label {return false}
    if lhs.ruleClassID != rhs.ruleClassID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_RuleClass: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".RuleClass"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "name"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.id)
      case 2: try decoder.decodeSingularStringField(value: &self.name)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_RuleClass, rhs: Analysis_RuleClass) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.name != rhs.name {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_AspectDescriptor: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".AspectDescriptor"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "name"),
    3: .same(proto: "parameters"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.id)
      case 2: try decoder.decodeSingularStringField(value: &self.name)
      case 3: try decoder.decodeRepeatedMessageField(value: &self.parameters)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 2)
    }
    if !self.parameters.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.parameters, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_AspectDescriptor, rhs: Analysis_AspectDescriptor) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.name != rhs.name {return false}
    if lhs.parameters != rhs.parameters {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_DepSetOfFiles: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".DepSetOfFiles"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .standard(proto: "transitive_dep_set_ids"),
    3: .standard(proto: "direct_artifact_ids"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.id)
      case 2: try decoder.decodeRepeatedStringField(value: &self.transitiveDepSetIds)
      case 3: try decoder.decodeRepeatedStringField(value: &self.directArtifactIds)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.transitiveDepSetIds.isEmpty {
      try visitor.visitRepeatedStringField(value: self.transitiveDepSetIds, fieldNumber: 2)
    }
    if !self.directArtifactIds.isEmpty {
      try visitor.visitRepeatedStringField(value: self.directArtifactIds, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_DepSetOfFiles, rhs: Analysis_DepSetOfFiles) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.transitiveDepSetIds != rhs.transitiveDepSetIds {return false}
    if lhs.directArtifactIds != rhs.directArtifactIds {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_Configuration: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Configuration"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "mnemonic"),
    3: .standard(proto: "platform_name"),
    4: .same(proto: "checksum"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.id)
      case 2: try decoder.decodeSingularStringField(value: &self.mnemonic)
      case 3: try decoder.decodeSingularStringField(value: &self.platformName)
      case 4: try decoder.decodeSingularStringField(value: &self.checksum)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.mnemonic.isEmpty {
      try visitor.visitSingularStringField(value: self.mnemonic, fieldNumber: 2)
    }
    if !self.platformName.isEmpty {
      try visitor.visitSingularStringField(value: self.platformName, fieldNumber: 3)
    }
    if !self.checksum.isEmpty {
      try visitor.visitSingularStringField(value: self.checksum, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_Configuration, rhs: Analysis_Configuration) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.mnemonic != rhs.mnemonic {return false}
    if lhs.platformName != rhs.platformName {return false}
    if lhs.checksum != rhs.checksum {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_KeyValuePair: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".KeyValuePair"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "key"),
    2: .same(proto: "value"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.key)
      case 2: try decoder.decodeSingularStringField(value: &self.value)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.key.isEmpty {
      try visitor.visitSingularStringField(value: self.key, fieldNumber: 1)
    }
    if !self.value.isEmpty {
      try visitor.visitSingularStringField(value: self.value, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_KeyValuePair, rhs: Analysis_KeyValuePair) -> Bool {
    if lhs.key != rhs.key {return false}
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_ConfiguredTarget: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ConfiguredTarget"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "target"),
    2: .same(proto: "configuration"),
  ]

  fileprivate class _StorageClass {
    var _target: BlazeQuery_Target? = nil
    var _configuration: Analysis_Configuration? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _target = source._target
      _configuration = source._configuration
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public var isInitialized: Bool {
    return withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._target, !v.isInitialized {return false}
      return true
    }
  }

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._target)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._configuration)
        default: break
        }
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._target {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._configuration {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_ConfiguredTarget, rhs: Analysis_ConfiguredTarget) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._target != rhs_storage._target {return false}
        if _storage._configuration != rhs_storage._configuration {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_CqueryResult: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".CqueryResult"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "results"),
  ]

  public var isInitialized: Bool {
    if !SwiftProtobuf.Internal.areAllInitialized(self.results) {return false}
    return true
  }

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.results)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.results.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.results, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_CqueryResult, rhs: Analysis_CqueryResult) -> Bool {
    if lhs.results != rhs.results {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Analysis_ParamFile: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ParamFile"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "exec_path"),
    2: .same(proto: "arguments"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.execPath)
      case 2: try decoder.decodeRepeatedStringField(value: &self.arguments)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.execPath.isEmpty {
      try visitor.visitSingularStringField(value: self.execPath, fieldNumber: 1)
    }
    if !self.arguments.isEmpty {
      try visitor.visitRepeatedStringField(value: self.arguments, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Analysis_ParamFile, rhs: Analysis_ParamFile) -> Bool {
    if lhs.execPath != rhs.execPath {return false}
    if lhs.arguments != rhs.arguments {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}