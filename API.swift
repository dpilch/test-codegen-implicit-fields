//  This file was automatically generated and should not be edited.

#if canImport(AWSAPIPlugin)
import Foundation

public protocol GraphQLInputValue {
}

public struct GraphQLVariable {
  let name: String
  
  public init(_ name: String) {
    self.name = name
  }
}

extension GraphQLVariable: GraphQLInputValue {
}

extension JSONEncodable {
  public func evaluate(with variables: [String: JSONEncodable]?) throws -> Any {
    return jsonValue
  }
}

public typealias GraphQLMap = [String: JSONEncodable?]

extension Dictionary where Key == String, Value == JSONEncodable? {
  public var withNilValuesRemoved: Dictionary<String, JSONEncodable> {
    var filtered = Dictionary<String, JSONEncodable>(minimumCapacity: count)
    for (key, value) in self {
      if value != nil {
        filtered[key] = value
      }
    }
    return filtered
  }
}

public protocol GraphQLMapConvertible: JSONEncodable {
  var graphQLMap: GraphQLMap { get }
}

public extension GraphQLMapConvertible {
  var jsonValue: Any {
    return graphQLMap.withNilValuesRemoved.jsonValue
  }
}

public typealias GraphQLID = String

public protocol APISwiftGraphQLOperation: AnyObject {
  
  static var operationString: String { get }
  static var requestString: String { get }
  static var operationIdentifier: String? { get }
  
  var variables: GraphQLMap? { get }
  
  associatedtype Data: GraphQLSelectionSet
}

public extension APISwiftGraphQLOperation {
  static var requestString: String {
    return operationString
  }

  static var operationIdentifier: String? {
    return nil
  }

  var variables: GraphQLMap? {
    return nil
  }
}

public protocol GraphQLQuery: APISwiftGraphQLOperation {}

public protocol GraphQLMutation: APISwiftGraphQLOperation {}

public protocol GraphQLSubscription: APISwiftGraphQLOperation {}

public protocol GraphQLFragment: GraphQLSelectionSet {
  static var possibleTypes: [String] { get }
}

public typealias Snapshot = [String: Any?]

public protocol GraphQLSelectionSet: Decodable {
  static var selections: [GraphQLSelection] { get }
  
  var snapshot: Snapshot { get }
  init(snapshot: Snapshot)
}

extension GraphQLSelectionSet {
    public init(from decoder: Decoder) throws {
        if let jsonObject = try? APISwiftJSONValue(from: decoder) {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(jsonObject)
            let decodedDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            let optionalDictionary = decodedDictionary.mapValues { $0 as Any? }

            self.init(snapshot: optionalDictionary)
        } else {
            self.init(snapshot: [:])
        }
    }
}

enum APISwiftJSONValue: Codable {
    case array([APISwiftJSONValue])
    case boolean(Bool)
    case number(Double)
    case object([String: APISwiftJSONValue])
    case string(String)
    case null
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode([String: APISwiftJSONValue].self) {
            self = .object(value)
        } else if let value = try? container.decode([APISwiftJSONValue].self) {
            self = .array(value)
        } else if let value = try? container.decode(Double.self) {
            self = .number(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .boolean(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else {
            self = .null
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .array(let value):
            try container.encode(value)
        case .boolean(let value):
            try container.encode(value)
        case .number(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .null:
            try container.encodeNil()
        }
    }
}

public protocol GraphQLSelection {
}

public struct GraphQLField: GraphQLSelection {
  let name: String
  let alias: String?
  let arguments: [String: GraphQLInputValue]?
  
  var responseKey: String {
    return alias ?? name
  }
  
  let type: GraphQLOutputType
  
  public init(_ name: String, alias: String? = nil, arguments: [String: GraphQLInputValue]? = nil, type: GraphQLOutputType) {
    self.name = name
    self.alias = alias
    
    self.arguments = arguments
    
    self.type = type
  }
}

public indirect enum GraphQLOutputType {
  case scalar(JSONDecodable.Type)
  case object([GraphQLSelection])
  case nonNull(GraphQLOutputType)
  case list(GraphQLOutputType)
  
  var namedType: GraphQLOutputType {
    switch self {
    case .nonNull(let innerType), .list(let innerType):
      return innerType.namedType
    case .scalar, .object:
      return self
    }
  }
}

public struct GraphQLBooleanCondition: GraphQLSelection {
  let variableName: String
  let inverted: Bool
  let selections: [GraphQLSelection]
  
  public init(variableName: String, inverted: Bool, selections: [GraphQLSelection]) {
    self.variableName = variableName
    self.inverted = inverted;
    self.selections = selections;
  }
}

public struct GraphQLTypeCondition: GraphQLSelection {
  let possibleTypes: [String]
  let selections: [GraphQLSelection]
  
  public init(possibleTypes: [String], selections: [GraphQLSelection]) {
    self.possibleTypes = possibleTypes
    self.selections = selections;
  }
}

public struct GraphQLFragmentSpread: GraphQLSelection {
  let fragment: GraphQLFragment.Type
  
  public init(_ fragment: GraphQLFragment.Type) {
    self.fragment = fragment
  }
}

public struct GraphQLTypeCase: GraphQLSelection {
  let variants: [String: [GraphQLSelection]]
  let `default`: [GraphQLSelection]
  
  public init(variants: [String: [GraphQLSelection]], default: [GraphQLSelection]) {
    self.variants = variants
    self.default = `default`;
  }
}

public typealias JSONObject = [String: Any]

public protocol JSONDecodable {
  init(jsonValue value: Any) throws
}

public protocol JSONEncodable: GraphQLInputValue {
  var jsonValue: Any { get }
}

public enum JSONDecodingError: Error, LocalizedError {
  case missingValue
  case nullValue
  case wrongType
  case couldNotConvert(value: Any, to: Any.Type)
  
  public var errorDescription: String? {
    switch self {
    case .missingValue:
      return "Missing value"
    case .nullValue:
      return "Unexpected null value"
    case .wrongType:
      return "Wrong type"
    case .couldNotConvert(let value, let expectedType):
      return "Could not convert \"\(value)\" to \(expectedType)"
    }
  }
}

extension String: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let string = value as? String else {
      throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
    }
    self = string
  }

  public var jsonValue: Any {
    return self
  }
}

extension Int: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let number = value as? NSNumber else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Int.self)
    }
    self = number.intValue
  }

  public var jsonValue: Any {
    return self
  }
}

extension Float: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let number = value as? NSNumber else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Float.self)
    }
    self = number.floatValue
  }

  public var jsonValue: Any {
    return self
  }
}

extension Double: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let number = value as? NSNumber else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Double.self)
    }
    self = number.doubleValue
  }

  public var jsonValue: Any {
    return self
  }
}

extension Bool: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let bool = value as? Bool else {
        throw JSONDecodingError.couldNotConvert(value: value, to: Bool.self)
    }
    self = bool
  }

  public var jsonValue: Any {
    return self
  }
}

extension RawRepresentable where RawValue: JSONDecodable {
  public init(jsonValue value: Any) throws {
    let rawValue = try RawValue(jsonValue: value)
    if let tempSelf = Self(rawValue: rawValue) {
      self = tempSelf
    } else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Self.self)
    }
  }
}

extension RawRepresentable where RawValue: JSONEncodable {
  public var jsonValue: Any {
    return rawValue.jsonValue
  }
}

extension Optional where Wrapped: JSONDecodable {
  public init(jsonValue value: Any) throws {
    if value is NSNull {
      self = .none
    } else {
      self = .some(try Wrapped(jsonValue: value))
    }
  }
}

extension Optional: JSONEncodable {
  public var jsonValue: Any {
    switch self {
    case .none:
      return NSNull()
    case .some(let wrapped as JSONEncodable):
      return wrapped.jsonValue
    default:
      fatalError("Optional is only JSONEncodable if Wrapped is")
    }
  }
}

extension Dictionary: JSONEncodable {
  public var jsonValue: Any {
    return jsonObject
  }
  
  public var jsonObject: JSONObject {
    var jsonObject = JSONObject(minimumCapacity: count)
    for (key, value) in self {
      if case let (key as String, value as JSONEncodable) = (key, value) {
        jsonObject[key] = value.jsonValue
      } else {
        fatalError("Dictionary is only JSONEncodable if Value is (and if Key is String)")
      }
    }
    return jsonObject
  }
}

extension Array: JSONEncodable {
  public var jsonValue: Any {
    return map() { element -> (Any) in
      if case let element as JSONEncodable = element {
        return element.jsonValue
      } else {
        fatalError("Array is only JSONEncodable if Element is")
      }
    }
  }
}

extension URL: JSONDecodable, JSONEncodable {
  public init(jsonValue value: Any) throws {
    guard let string = value as? String else {
      throw JSONDecodingError.couldNotConvert(value: value, to: URL.self)
    }
    self.init(string: string)!
  }

  public var jsonValue: Any {
    return self.absoluteString
  }
}

extension Dictionary {
  static func += (lhs: inout Dictionary, rhs: Dictionary) {
    lhs.merge(rhs) { (_, new) in new }
  }
}

#elseif canImport(AWSAppSync)
import AWSAppSync
#endif

public struct CreatePatientInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ssn: GraphQLID, givenName: String, familyName: String) {
    graphQLMap = ["ssn": ssn, "givenName": givenName, "familyName": familyName]
  }

  public var ssn: GraphQLID {
    get {
      return graphQLMap["ssn"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ssn")
    }
  }

  public var givenName: String {
    get {
      return graphQLMap["givenName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "givenName")
    }
  }

  public var familyName: String {
    get {
      return graphQLMap["familyName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "familyName")
    }
  }
}

public struct ModelPatientConditionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(and: [ModelPatientConditionInput?]? = nil, or: [ModelPatientConditionInput?]? = nil, not: ModelPatientConditionInput? = nil) {
    graphQLMap = ["and": and, "or": or, "not": not]
  }

  public var and: [ModelPatientConditionInput?]? {
    get {
      return graphQLMap["and"] as! [ModelPatientConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelPatientConditionInput?]? {
    get {
      return graphQLMap["or"] as! [ModelPatientConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelPatientConditionInput? {
    get {
      return graphQLMap["not"] as! ModelPatientConditionInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct UpdatePatientInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ssn: GraphQLID, givenName: String, familyName: String) {
    graphQLMap = ["ssn": ssn, "givenName": givenName, "familyName": familyName]
  }

  public var ssn: GraphQLID {
    get {
      return graphQLMap["ssn"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ssn")
    }
  }

  public var givenName: String {
    get {
      return graphQLMap["givenName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "givenName")
    }
  }

  public var familyName: String {
    get {
      return graphQLMap["familyName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "familyName")
    }
  }
}

public struct DeletePatientInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ssn: GraphQLID, givenName: String, familyName: String) {
    graphQLMap = ["ssn": ssn, "givenName": givenName, "familyName": familyName]
  }

  public var ssn: GraphQLID {
    get {
      return graphQLMap["ssn"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ssn")
    }
  }

  public var givenName: String {
    get {
      return graphQLMap["givenName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "givenName")
    }
  }

  public var familyName: String {
    get {
      return graphQLMap["familyName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "familyName")
    }
  }
}

public struct CreateMedicalAppointmentInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(appointmentReference: GraphQLID, provider: String? = nil, date: String? = nil, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
    graphQLMap = ["appointmentReference": appointmentReference, "provider": provider, "date": date, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName]
  }

  public var appointmentReference: GraphQLID {
    get {
      return graphQLMap["appointmentReference"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "appointmentReference")
    }
  }

  public var provider: String? {
    get {
      return graphQLMap["provider"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "provider")
    }
  }

  public var date: String? {
    get {
      return graphQLMap["date"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var medicalAppointmentPatientSsn: GraphQLID? {
    get {
      return graphQLMap["medicalAppointmentPatientSsn"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
    }
  }

  public var medicalAppointmentPatientGivenName: String? {
    get {
      return graphQLMap["medicalAppointmentPatientGivenName"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
    }
  }

  public var medicalAppointmentPatientFamilyName: String? {
    get {
      return graphQLMap["medicalAppointmentPatientFamilyName"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
    }
  }
}

public struct ModelMedicalAppointmentConditionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(provider: ModelStringInput? = nil, date: ModelStringInput? = nil, and: [ModelMedicalAppointmentConditionInput?]? = nil, or: [ModelMedicalAppointmentConditionInput?]? = nil, not: ModelMedicalAppointmentConditionInput? = nil, medicalAppointmentPatientSsn: ModelIDInput? = nil, medicalAppointmentPatientGivenName: ModelStringInput? = nil, medicalAppointmentPatientFamilyName: ModelStringInput? = nil) {
    graphQLMap = ["provider": provider, "date": date, "and": and, "or": or, "not": not, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName]
  }

  public var provider: ModelStringInput? {
    get {
      return graphQLMap["provider"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "provider")
    }
  }

  public var date: ModelStringInput? {
    get {
      return graphQLMap["date"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var and: [ModelMedicalAppointmentConditionInput?]? {
    get {
      return graphQLMap["and"] as! [ModelMedicalAppointmentConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelMedicalAppointmentConditionInput?]? {
    get {
      return graphQLMap["or"] as! [ModelMedicalAppointmentConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelMedicalAppointmentConditionInput? {
    get {
      return graphQLMap["not"] as! ModelMedicalAppointmentConditionInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }

  public var medicalAppointmentPatientSsn: ModelIDInput? {
    get {
      return graphQLMap["medicalAppointmentPatientSsn"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
    }
  }

  public var medicalAppointmentPatientGivenName: ModelStringInput? {
    get {
      return graphQLMap["medicalAppointmentPatientGivenName"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
    }
  }

  public var medicalAppointmentPatientFamilyName: ModelStringInput? {
    get {
      return graphQLMap["medicalAppointmentPatientFamilyName"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
    }
  }
}

public struct ModelStringInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: String? = nil, eq: String? = nil, le: String? = nil, lt: String? = nil, ge: String? = nil, gt: String? = nil, contains: String? = nil, notContains: String? = nil, between: [String?]? = nil, beginsWith: String? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil, size: ModelSizeInput? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "attributeExists": attributeExists, "attributeType": attributeType, "size": size]
  }

  public var ne: String? {
    get {
      return graphQLMap["ne"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: String? {
    get {
      return graphQLMap["eq"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: String? {
    get {
      return graphQLMap["le"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: String? {
    get {
      return graphQLMap["lt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: String? {
    get {
      return graphQLMap["ge"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: String? {
    get {
      return graphQLMap["gt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: String? {
    get {
      return graphQLMap["contains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: String? {
    get {
      return graphQLMap["notContains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [String?]? {
    get {
      return graphQLMap["between"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: String? {
    get {
      return graphQLMap["beginsWith"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var attributeExists: Bool? {
    get {
      return graphQLMap["attributeExists"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeExists")
    }
  }

  public var attributeType: ModelAttributeTypes? {
    get {
      return graphQLMap["attributeType"] as! ModelAttributeTypes?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeType")
    }
  }

  public var size: ModelSizeInput? {
    get {
      return graphQLMap["size"] as! ModelSizeInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
    }
  }
}

public enum ModelAttributeTypes: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  public typealias RawValue = String
  case binary
  case binarySet
  case bool
  case list
  case map
  case number
  case numberSet
  case string
  case stringSet
  case null
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "binary": self = .binary
      case "binarySet": self = .binarySet
      case "bool": self = .bool
      case "list": self = .list
      case "map": self = .map
      case "number": self = .number
      case "numberSet": self = .numberSet
      case "string": self = .string
      case "stringSet": self = .stringSet
      case "_null": self = .null
      default: self = .unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .binary: return "binary"
      case .binarySet: return "binarySet"
      case .bool: return "bool"
      case .list: return "list"
      case .map: return "map"
      case .number: return "number"
      case .numberSet: return "numberSet"
      case .string: return "string"
      case .stringSet: return "stringSet"
      case .null: return "_null"
      case .unknown(let value): return value
    }
  }

  public static func == (lhs: ModelAttributeTypes, rhs: ModelAttributeTypes) -> Bool {
    switch (lhs, rhs) {
      case (.binary, .binary): return true
      case (.binarySet, .binarySet): return true
      case (.bool, .bool): return true
      case (.list, .list): return true
      case (.map, .map): return true
      case (.number, .number): return true
      case (.numberSet, .numberSet): return true
      case (.string, .string): return true
      case (.stringSet, .stringSet): return true
      case (.null, .null): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public struct ModelSizeInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: Int? = nil, eq: Int? = nil, le: Int? = nil, lt: Int? = nil, ge: Int? = nil, gt: Int? = nil, between: [Int?]? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "between": between]
  }

  public var ne: Int? {
    get {
      return graphQLMap["ne"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: Int? {
    get {
      return graphQLMap["eq"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: Int? {
    get {
      return graphQLMap["le"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: Int? {
    get {
      return graphQLMap["lt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: Int? {
    get {
      return graphQLMap["ge"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: Int? {
    get {
      return graphQLMap["gt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var between: [Int?]? {
    get {
      return graphQLMap["between"] as! [Int?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }
}

public struct ModelIDInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: GraphQLID? = nil, eq: GraphQLID? = nil, le: GraphQLID? = nil, lt: GraphQLID? = nil, ge: GraphQLID? = nil, gt: GraphQLID? = nil, contains: GraphQLID? = nil, notContains: GraphQLID? = nil, between: [GraphQLID?]? = nil, beginsWith: GraphQLID? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil, size: ModelSizeInput? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "attributeExists": attributeExists, "attributeType": attributeType, "size": size]
  }

  public var ne: GraphQLID? {
    get {
      return graphQLMap["ne"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: GraphQLID? {
    get {
      return graphQLMap["eq"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: GraphQLID? {
    get {
      return graphQLMap["le"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: GraphQLID? {
    get {
      return graphQLMap["lt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: GraphQLID? {
    get {
      return graphQLMap["ge"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: GraphQLID? {
    get {
      return graphQLMap["gt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: GraphQLID? {
    get {
      return graphQLMap["contains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: GraphQLID? {
    get {
      return graphQLMap["notContains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [GraphQLID?]? {
    get {
      return graphQLMap["between"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: GraphQLID? {
    get {
      return graphQLMap["beginsWith"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var attributeExists: Bool? {
    get {
      return graphQLMap["attributeExists"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeExists")
    }
  }

  public var attributeType: ModelAttributeTypes? {
    get {
      return graphQLMap["attributeType"] as! ModelAttributeTypes?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeType")
    }
  }

  public var size: ModelSizeInput? {
    get {
      return graphQLMap["size"] as! ModelSizeInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
    }
  }
}

public struct UpdateMedicalAppointmentInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(appointmentReference: GraphQLID, provider: String? = nil, date: String? = nil, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
    graphQLMap = ["appointmentReference": appointmentReference, "provider": provider, "date": date, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName]
  }

  public var appointmentReference: GraphQLID {
    get {
      return graphQLMap["appointmentReference"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "appointmentReference")
    }
  }

  public var provider: String? {
    get {
      return graphQLMap["provider"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "provider")
    }
  }

  public var date: String? {
    get {
      return graphQLMap["date"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var medicalAppointmentPatientSsn: GraphQLID? {
    get {
      return graphQLMap["medicalAppointmentPatientSsn"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
    }
  }

  public var medicalAppointmentPatientGivenName: String? {
    get {
      return graphQLMap["medicalAppointmentPatientGivenName"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
    }
  }

  public var medicalAppointmentPatientFamilyName: String? {
    get {
      return graphQLMap["medicalAppointmentPatientFamilyName"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
    }
  }
}

public struct DeleteMedicalAppointmentInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(appointmentReference: GraphQLID) {
    graphQLMap = ["appointmentReference": appointmentReference]
  }

  public var appointmentReference: GraphQLID {
    get {
      return graphQLMap["appointmentReference"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "appointmentReference")
    }
  }
}

public struct CreateTodoInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(content: String? = nil, id: GraphQLID? = nil) {
    graphQLMap = ["content": content, "id": id]
  }

  public var content: String? {
    get {
      return graphQLMap["content"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  public var id: GraphQLID? {
    get {
      return graphQLMap["id"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }
}

public struct ModelTodoConditionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(content: ModelStringInput? = nil, and: [ModelTodoConditionInput?]? = nil, or: [ModelTodoConditionInput?]? = nil, not: ModelTodoConditionInput? = nil) {
    graphQLMap = ["content": content, "and": and, "or": or, "not": not]
  }

  public var content: ModelStringInput? {
    get {
      return graphQLMap["content"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  public var and: [ModelTodoConditionInput?]? {
    get {
      return graphQLMap["and"] as! [ModelTodoConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelTodoConditionInput?]? {
    get {
      return graphQLMap["or"] as! [ModelTodoConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelTodoConditionInput? {
    get {
      return graphQLMap["not"] as! ModelTodoConditionInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct UpdateTodoInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(content: String? = nil, id: GraphQLID) {
    graphQLMap = ["content": content, "id": id]
  }

  public var content: String? {
    get {
      return graphQLMap["content"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }
}

public struct DeleteTodoInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID) {
    graphQLMap = ["id": id]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }
}

public struct ModelPatientPrimaryCompositeKeyConditionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(eq: ModelPatientPrimaryCompositeKeyInput? = nil, le: ModelPatientPrimaryCompositeKeyInput? = nil, lt: ModelPatientPrimaryCompositeKeyInput? = nil, ge: ModelPatientPrimaryCompositeKeyInput? = nil, gt: ModelPatientPrimaryCompositeKeyInput? = nil, between: [ModelPatientPrimaryCompositeKeyInput?]? = nil, beginsWith: ModelPatientPrimaryCompositeKeyInput? = nil) {
    graphQLMap = ["eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "between": between, "beginsWith": beginsWith]
  }

  public var eq: ModelPatientPrimaryCompositeKeyInput? {
    get {
      return graphQLMap["eq"] as! ModelPatientPrimaryCompositeKeyInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: ModelPatientPrimaryCompositeKeyInput? {
    get {
      return graphQLMap["le"] as! ModelPatientPrimaryCompositeKeyInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: ModelPatientPrimaryCompositeKeyInput? {
    get {
      return graphQLMap["lt"] as! ModelPatientPrimaryCompositeKeyInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: ModelPatientPrimaryCompositeKeyInput? {
    get {
      return graphQLMap["ge"] as! ModelPatientPrimaryCompositeKeyInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: ModelPatientPrimaryCompositeKeyInput? {
    get {
      return graphQLMap["gt"] as! ModelPatientPrimaryCompositeKeyInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var between: [ModelPatientPrimaryCompositeKeyInput?]? {
    get {
      return graphQLMap["between"] as! [ModelPatientPrimaryCompositeKeyInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: ModelPatientPrimaryCompositeKeyInput? {
    get {
      return graphQLMap["beginsWith"] as! ModelPatientPrimaryCompositeKeyInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }
}

public struct ModelPatientPrimaryCompositeKeyInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(givenName: String? = nil, familyName: String? = nil) {
    graphQLMap = ["givenName": givenName, "familyName": familyName]
  }

  public var givenName: String? {
    get {
      return graphQLMap["givenName"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "givenName")
    }
  }

  public var familyName: String? {
    get {
      return graphQLMap["familyName"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "familyName")
    }
  }
}

public struct ModelPatientFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ssn: ModelIDInput? = nil, givenName: ModelStringInput? = nil, familyName: ModelStringInput? = nil, and: [ModelPatientFilterInput?]? = nil, or: [ModelPatientFilterInput?]? = nil, not: ModelPatientFilterInput? = nil) {
    graphQLMap = ["ssn": ssn, "givenName": givenName, "familyName": familyName, "and": and, "or": or, "not": not]
  }

  public var ssn: ModelIDInput? {
    get {
      return graphQLMap["ssn"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ssn")
    }
  }

  public var givenName: ModelStringInput? {
    get {
      return graphQLMap["givenName"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "givenName")
    }
  }

  public var familyName: ModelStringInput? {
    get {
      return graphQLMap["familyName"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "familyName")
    }
  }

  public var and: [ModelPatientFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelPatientFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelPatientFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelPatientFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelPatientFilterInput? {
    get {
      return graphQLMap["not"] as! ModelPatientFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public enum ModelSortDirection: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  public typealias RawValue = String
  case asc
  case desc
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ASC": self = .asc
      case "DESC": self = .desc
      default: self = .unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .asc: return "ASC"
      case .desc: return "DESC"
      case .unknown(let value): return value
    }
  }

  public static func == (lhs: ModelSortDirection, rhs: ModelSortDirection) -> Bool {
    switch (lhs, rhs) {
      case (.asc, .asc): return true
      case (.desc, .desc): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public struct ModelMedicalAppointmentFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(appointmentReference: ModelIDInput? = nil, provider: ModelStringInput? = nil, date: ModelStringInput? = nil, and: [ModelMedicalAppointmentFilterInput?]? = nil, or: [ModelMedicalAppointmentFilterInput?]? = nil, not: ModelMedicalAppointmentFilterInput? = nil, medicalAppointmentPatientSsn: ModelIDInput? = nil, medicalAppointmentPatientGivenName: ModelStringInput? = nil, medicalAppointmentPatientFamilyName: ModelStringInput? = nil) {
    graphQLMap = ["appointmentReference": appointmentReference, "provider": provider, "date": date, "and": and, "or": or, "not": not, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName]
  }

  public var appointmentReference: ModelIDInput? {
    get {
      return graphQLMap["appointmentReference"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "appointmentReference")
    }
  }

  public var provider: ModelStringInput? {
    get {
      return graphQLMap["provider"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "provider")
    }
  }

  public var date: ModelStringInput? {
    get {
      return graphQLMap["date"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var and: [ModelMedicalAppointmentFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelMedicalAppointmentFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelMedicalAppointmentFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelMedicalAppointmentFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelMedicalAppointmentFilterInput? {
    get {
      return graphQLMap["not"] as! ModelMedicalAppointmentFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }

  public var medicalAppointmentPatientSsn: ModelIDInput? {
    get {
      return graphQLMap["medicalAppointmentPatientSsn"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
    }
  }

  public var medicalAppointmentPatientGivenName: ModelStringInput? {
    get {
      return graphQLMap["medicalAppointmentPatientGivenName"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
    }
  }

  public var medicalAppointmentPatientFamilyName: ModelStringInput? {
    get {
      return graphQLMap["medicalAppointmentPatientFamilyName"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
    }
  }
}

public struct ModelTodoFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(content: ModelStringInput? = nil, and: [ModelTodoFilterInput?]? = nil, or: [ModelTodoFilterInput?]? = nil, not: ModelTodoFilterInput? = nil) {
    graphQLMap = ["content": content, "and": and, "or": or, "not": not]
  }

  public var content: ModelStringInput? {
    get {
      return graphQLMap["content"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  public var and: [ModelTodoFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelTodoFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelTodoFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelTodoFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelTodoFilterInput? {
    get {
      return graphQLMap["not"] as! ModelTodoFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct ModelSubscriptionPatientFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ssn: ModelSubscriptionIDInput? = nil, givenName: ModelSubscriptionStringInput? = nil, familyName: ModelSubscriptionStringInput? = nil, and: [ModelSubscriptionPatientFilterInput?]? = nil, or: [ModelSubscriptionPatientFilterInput?]? = nil) {
    graphQLMap = ["ssn": ssn, "givenName": givenName, "familyName": familyName, "and": and, "or": or]
  }

  public var ssn: ModelSubscriptionIDInput? {
    get {
      return graphQLMap["ssn"] as! ModelSubscriptionIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ssn")
    }
  }

  public var givenName: ModelSubscriptionStringInput? {
    get {
      return graphQLMap["givenName"] as! ModelSubscriptionStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "givenName")
    }
  }

  public var familyName: ModelSubscriptionStringInput? {
    get {
      return graphQLMap["familyName"] as! ModelSubscriptionStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "familyName")
    }
  }

  public var and: [ModelSubscriptionPatientFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelSubscriptionPatientFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelSubscriptionPatientFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelSubscriptionPatientFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }
}

public struct ModelSubscriptionIDInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: GraphQLID? = nil, eq: GraphQLID? = nil, le: GraphQLID? = nil, lt: GraphQLID? = nil, ge: GraphQLID? = nil, gt: GraphQLID? = nil, contains: GraphQLID? = nil, notContains: GraphQLID? = nil, between: [GraphQLID?]? = nil, beginsWith: GraphQLID? = nil, `in`: [GraphQLID?]? = nil, notIn: [GraphQLID?]? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "in": `in`, "notIn": notIn]
  }

  public var ne: GraphQLID? {
    get {
      return graphQLMap["ne"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: GraphQLID? {
    get {
      return graphQLMap["eq"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: GraphQLID? {
    get {
      return graphQLMap["le"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: GraphQLID? {
    get {
      return graphQLMap["lt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: GraphQLID? {
    get {
      return graphQLMap["ge"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: GraphQLID? {
    get {
      return graphQLMap["gt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: GraphQLID? {
    get {
      return graphQLMap["contains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: GraphQLID? {
    get {
      return graphQLMap["notContains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [GraphQLID?]? {
    get {
      return graphQLMap["between"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: GraphQLID? {
    get {
      return graphQLMap["beginsWith"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var `in`: [GraphQLID?]? {
    get {
      return graphQLMap["in"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "in")
    }
  }

  public var notIn: [GraphQLID?]? {
    get {
      return graphQLMap["notIn"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notIn")
    }
  }
}

public struct ModelSubscriptionStringInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: String? = nil, eq: String? = nil, le: String? = nil, lt: String? = nil, ge: String? = nil, gt: String? = nil, contains: String? = nil, notContains: String? = nil, between: [String?]? = nil, beginsWith: String? = nil, `in`: [String?]? = nil, notIn: [String?]? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "in": `in`, "notIn": notIn]
  }

  public var ne: String? {
    get {
      return graphQLMap["ne"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: String? {
    get {
      return graphQLMap["eq"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: String? {
    get {
      return graphQLMap["le"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: String? {
    get {
      return graphQLMap["lt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: String? {
    get {
      return graphQLMap["ge"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: String? {
    get {
      return graphQLMap["gt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: String? {
    get {
      return graphQLMap["contains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: String? {
    get {
      return graphQLMap["notContains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [String?]? {
    get {
      return graphQLMap["between"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: String? {
    get {
      return graphQLMap["beginsWith"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var `in`: [String?]? {
    get {
      return graphQLMap["in"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "in")
    }
  }

  public var notIn: [String?]? {
    get {
      return graphQLMap["notIn"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notIn")
    }
  }
}

public struct ModelSubscriptionMedicalAppointmentFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(appointmentReference: ModelSubscriptionIDInput? = nil, provider: ModelSubscriptionStringInput? = nil, date: ModelSubscriptionStringInput? = nil, and: [ModelSubscriptionMedicalAppointmentFilterInput?]? = nil, or: [ModelSubscriptionMedicalAppointmentFilterInput?]? = nil) {
    graphQLMap = ["appointmentReference": appointmentReference, "provider": provider, "date": date, "and": and, "or": or]
  }

  public var appointmentReference: ModelSubscriptionIDInput? {
    get {
      return graphQLMap["appointmentReference"] as! ModelSubscriptionIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "appointmentReference")
    }
  }

  public var provider: ModelSubscriptionStringInput? {
    get {
      return graphQLMap["provider"] as! ModelSubscriptionStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "provider")
    }
  }

  public var date: ModelSubscriptionStringInput? {
    get {
      return graphQLMap["date"] as! ModelSubscriptionStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var and: [ModelSubscriptionMedicalAppointmentFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelSubscriptionMedicalAppointmentFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelSubscriptionMedicalAppointmentFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelSubscriptionMedicalAppointmentFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }
}

public struct ModelSubscriptionTodoFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(content: ModelSubscriptionStringInput? = nil, and: [ModelSubscriptionTodoFilterInput?]? = nil, or: [ModelSubscriptionTodoFilterInput?]? = nil) {
    graphQLMap = ["content": content, "and": and, "or": or]
  }

  public var content: ModelSubscriptionStringInput? {
    get {
      return graphQLMap["content"] as! ModelSubscriptionStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "content")
    }
  }

  public var and: [ModelSubscriptionTodoFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelSubscriptionTodoFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelSubscriptionTodoFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelSubscriptionTodoFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }
}

public final class CreatePatientMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreatePatient($input: CreatePatientInput!, $condition: ModelPatientConditionInput) {\n  createPatient(input: $input, condition: $condition) {\n    __typename\n    ssn\n    givenName\n    familyName\n    createdAt\n    updatedAt\n  }\n}"

  public var input: CreatePatientInput
  public var condition: ModelPatientConditionInput?

  public init(input: CreatePatientInput, condition: ModelPatientConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createPatient", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(CreatePatient.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createPatient: CreatePatient? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "createPatient": createPatient.flatMap { $0.snapshot }])
    }

    public var createPatient: CreatePatient? {
      get {
        return (snapshot["createPatient"] as? Snapshot).flatMap { CreatePatient(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createPatient")
      }
    }

    public struct CreatePatient: GraphQLSelectionSet {
      public static let possibleTypes = ["Patient"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ssn: GraphQLID {
        get {
          return snapshot["ssn"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "ssn")
        }
      }

      public var givenName: String {
        get {
          return snapshot["givenName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "givenName")
        }
      }

      public var familyName: String {
        get {
          return snapshot["familyName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "familyName")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class UpdatePatientMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdatePatient($input: UpdatePatientInput!, $condition: ModelPatientConditionInput) {\n  updatePatient(input: $input, condition: $condition) {\n    __typename\n    ssn\n    givenName\n    familyName\n    createdAt\n    updatedAt\n  }\n}"

  public var input: UpdatePatientInput
  public var condition: ModelPatientConditionInput?

  public init(input: UpdatePatientInput, condition: ModelPatientConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updatePatient", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(UpdatePatient.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updatePatient: UpdatePatient? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "updatePatient": updatePatient.flatMap { $0.snapshot }])
    }

    public var updatePatient: UpdatePatient? {
      get {
        return (snapshot["updatePatient"] as? Snapshot).flatMap { UpdatePatient(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "updatePatient")
      }
    }

    public struct UpdatePatient: GraphQLSelectionSet {
      public static let possibleTypes = ["Patient"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ssn: GraphQLID {
        get {
          return snapshot["ssn"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "ssn")
        }
      }

      public var givenName: String {
        get {
          return snapshot["givenName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "givenName")
        }
      }

      public var familyName: String {
        get {
          return snapshot["familyName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "familyName")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class DeletePatientMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeletePatient($input: DeletePatientInput!, $condition: ModelPatientConditionInput) {\n  deletePatient(input: $input, condition: $condition) {\n    __typename\n    ssn\n    givenName\n    familyName\n    createdAt\n    updatedAt\n  }\n}"

  public var input: DeletePatientInput
  public var condition: ModelPatientConditionInput?

  public init(input: DeletePatientInput, condition: ModelPatientConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deletePatient", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(DeletePatient.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deletePatient: DeletePatient? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deletePatient": deletePatient.flatMap { $0.snapshot }])
    }

    public var deletePatient: DeletePatient? {
      get {
        return (snapshot["deletePatient"] as? Snapshot).flatMap { DeletePatient(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deletePatient")
      }
    }

    public struct DeletePatient: GraphQLSelectionSet {
      public static let possibleTypes = ["Patient"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ssn: GraphQLID {
        get {
          return snapshot["ssn"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "ssn")
        }
      }

      public var givenName: String {
        get {
          return snapshot["givenName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "givenName")
        }
      }

      public var familyName: String {
        get {
          return snapshot["familyName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "familyName")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class CreateMedicalAppointmentMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateMedicalAppointment($input: CreateMedicalAppointmentInput!, $condition: ModelMedicalAppointmentConditionInput) {\n  createMedicalAppointment(input: $input, condition: $condition) {\n    __typename\n    appointmentReference\n    patient {\n      __typename\n      ssn\n      givenName\n      familyName\n      createdAt\n      updatedAt\n    }\n    provider\n    date\n    createdAt\n    updatedAt\n    medicalAppointmentPatientSsn\n    medicalAppointmentPatientGivenName\n    medicalAppointmentPatientFamilyName\n  }\n}"

  public var input: CreateMedicalAppointmentInput
  public var condition: ModelMedicalAppointmentConditionInput?

  public init(input: CreateMedicalAppointmentInput, condition: ModelMedicalAppointmentConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createMedicalAppointment", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(CreateMedicalAppointment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createMedicalAppointment: CreateMedicalAppointment? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "createMedicalAppointment": createMedicalAppointment.flatMap { $0.snapshot }])
    }

    public var createMedicalAppointment: CreateMedicalAppointment? {
      get {
        return (snapshot["createMedicalAppointment"] as? Snapshot).flatMap { CreateMedicalAppointment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createMedicalAppointment")
      }
    }

    public struct CreateMedicalAppointment: GraphQLSelectionSet {
      public static let possibleTypes = ["MedicalAppointment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("appointmentReference", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("patient", type: .object(Patient.selections)),
        GraphQLField("provider", type: .scalar(String.self)),
        GraphQLField("date", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("medicalAppointmentPatientSsn", type: .scalar(GraphQLID.self)),
        GraphQLField("medicalAppointmentPatientGivenName", type: .scalar(String.self)),
        GraphQLField("medicalAppointmentPatientFamilyName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(appointmentReference: GraphQLID, patient: Patient? = nil, provider: String? = nil, date: String? = nil, createdAt: String, updatedAt: String, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
        self.init(snapshot: ["__typename": "MedicalAppointment", "appointmentReference": appointmentReference, "patient": patient.flatMap { $0.snapshot }, "provider": provider, "date": date, "createdAt": createdAt, "updatedAt": updatedAt, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var appointmentReference: GraphQLID {
        get {
          return snapshot["appointmentReference"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "appointmentReference")
        }
      }

      public var patient: Patient? {
        get {
          return (snapshot["patient"] as? Snapshot).flatMap { Patient(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "patient")
        }
      }

      public var provider: String? {
        get {
          return snapshot["provider"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "provider")
        }
      }

      public var date: String? {
        get {
          return snapshot["date"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var medicalAppointmentPatientSsn: GraphQLID? {
        get {
          return snapshot["medicalAppointmentPatientSsn"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
        }
      }

      public var medicalAppointmentPatientGivenName: String? {
        get {
          return snapshot["medicalAppointmentPatientGivenName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
        }
      }

      public var medicalAppointmentPatientFamilyName: String? {
        get {
          return snapshot["medicalAppointmentPatientFamilyName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
        }
      }

      public struct Patient: GraphQLSelectionSet {
        public static let possibleTypes = ["Patient"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
          GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var ssn: GraphQLID {
          get {
            return snapshot["ssn"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "ssn")
          }
        }

        public var givenName: String {
          get {
            return snapshot["givenName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "givenName")
          }
        }

        public var familyName: String {
          get {
            return snapshot["familyName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "familyName")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class UpdateMedicalAppointmentMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdateMedicalAppointment($input: UpdateMedicalAppointmentInput!, $condition: ModelMedicalAppointmentConditionInput) {\n  updateMedicalAppointment(input: $input, condition: $condition) {\n    __typename\n    appointmentReference\n    patient {\n      __typename\n      ssn\n      givenName\n      familyName\n      createdAt\n      updatedAt\n    }\n    provider\n    date\n    createdAt\n    updatedAt\n    medicalAppointmentPatientSsn\n    medicalAppointmentPatientGivenName\n    medicalAppointmentPatientFamilyName\n  }\n}"

  public var input: UpdateMedicalAppointmentInput
  public var condition: ModelMedicalAppointmentConditionInput?

  public init(input: UpdateMedicalAppointmentInput, condition: ModelMedicalAppointmentConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateMedicalAppointment", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(UpdateMedicalAppointment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updateMedicalAppointment: UpdateMedicalAppointment? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "updateMedicalAppointment": updateMedicalAppointment.flatMap { $0.snapshot }])
    }

    public var updateMedicalAppointment: UpdateMedicalAppointment? {
      get {
        return (snapshot["updateMedicalAppointment"] as? Snapshot).flatMap { UpdateMedicalAppointment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "updateMedicalAppointment")
      }
    }

    public struct UpdateMedicalAppointment: GraphQLSelectionSet {
      public static let possibleTypes = ["MedicalAppointment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("appointmentReference", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("patient", type: .object(Patient.selections)),
        GraphQLField("provider", type: .scalar(String.self)),
        GraphQLField("date", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("medicalAppointmentPatientSsn", type: .scalar(GraphQLID.self)),
        GraphQLField("medicalAppointmentPatientGivenName", type: .scalar(String.self)),
        GraphQLField("medicalAppointmentPatientFamilyName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(appointmentReference: GraphQLID, patient: Patient? = nil, provider: String? = nil, date: String? = nil, createdAt: String, updatedAt: String, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
        self.init(snapshot: ["__typename": "MedicalAppointment", "appointmentReference": appointmentReference, "patient": patient.flatMap { $0.snapshot }, "provider": provider, "date": date, "createdAt": createdAt, "updatedAt": updatedAt, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var appointmentReference: GraphQLID {
        get {
          return snapshot["appointmentReference"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "appointmentReference")
        }
      }

      public var patient: Patient? {
        get {
          return (snapshot["patient"] as? Snapshot).flatMap { Patient(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "patient")
        }
      }

      public var provider: String? {
        get {
          return snapshot["provider"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "provider")
        }
      }

      public var date: String? {
        get {
          return snapshot["date"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var medicalAppointmentPatientSsn: GraphQLID? {
        get {
          return snapshot["medicalAppointmentPatientSsn"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
        }
      }

      public var medicalAppointmentPatientGivenName: String? {
        get {
          return snapshot["medicalAppointmentPatientGivenName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
        }
      }

      public var medicalAppointmentPatientFamilyName: String? {
        get {
          return snapshot["medicalAppointmentPatientFamilyName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
        }
      }

      public struct Patient: GraphQLSelectionSet {
        public static let possibleTypes = ["Patient"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
          GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var ssn: GraphQLID {
          get {
            return snapshot["ssn"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "ssn")
          }
        }

        public var givenName: String {
          get {
            return snapshot["givenName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "givenName")
          }
        }

        public var familyName: String {
          get {
            return snapshot["familyName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "familyName")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class DeleteMedicalAppointmentMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteMedicalAppointment($input: DeleteMedicalAppointmentInput!, $condition: ModelMedicalAppointmentConditionInput) {\n  deleteMedicalAppointment(input: $input, condition: $condition) {\n    __typename\n    appointmentReference\n    patient {\n      __typename\n      ssn\n      givenName\n      familyName\n      createdAt\n      updatedAt\n    }\n    provider\n    date\n    createdAt\n    updatedAt\n    medicalAppointmentPatientSsn\n    medicalAppointmentPatientGivenName\n    medicalAppointmentPatientFamilyName\n  }\n}"

  public var input: DeleteMedicalAppointmentInput
  public var condition: ModelMedicalAppointmentConditionInput?

  public init(input: DeleteMedicalAppointmentInput, condition: ModelMedicalAppointmentConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteMedicalAppointment", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(DeleteMedicalAppointment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deleteMedicalAppointment: DeleteMedicalAppointment? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deleteMedicalAppointment": deleteMedicalAppointment.flatMap { $0.snapshot }])
    }

    public var deleteMedicalAppointment: DeleteMedicalAppointment? {
      get {
        return (snapshot["deleteMedicalAppointment"] as? Snapshot).flatMap { DeleteMedicalAppointment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deleteMedicalAppointment")
      }
    }

    public struct DeleteMedicalAppointment: GraphQLSelectionSet {
      public static let possibleTypes = ["MedicalAppointment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("appointmentReference", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("patient", type: .object(Patient.selections)),
        GraphQLField("provider", type: .scalar(String.self)),
        GraphQLField("date", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("medicalAppointmentPatientSsn", type: .scalar(GraphQLID.self)),
        GraphQLField("medicalAppointmentPatientGivenName", type: .scalar(String.self)),
        GraphQLField("medicalAppointmentPatientFamilyName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(appointmentReference: GraphQLID, patient: Patient? = nil, provider: String? = nil, date: String? = nil, createdAt: String, updatedAt: String, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
        self.init(snapshot: ["__typename": "MedicalAppointment", "appointmentReference": appointmentReference, "patient": patient.flatMap { $0.snapshot }, "provider": provider, "date": date, "createdAt": createdAt, "updatedAt": updatedAt, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var appointmentReference: GraphQLID {
        get {
          return snapshot["appointmentReference"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "appointmentReference")
        }
      }

      public var patient: Patient? {
        get {
          return (snapshot["patient"] as? Snapshot).flatMap { Patient(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "patient")
        }
      }

      public var provider: String? {
        get {
          return snapshot["provider"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "provider")
        }
      }

      public var date: String? {
        get {
          return snapshot["date"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var medicalAppointmentPatientSsn: GraphQLID? {
        get {
          return snapshot["medicalAppointmentPatientSsn"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
        }
      }

      public var medicalAppointmentPatientGivenName: String? {
        get {
          return snapshot["medicalAppointmentPatientGivenName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
        }
      }

      public var medicalAppointmentPatientFamilyName: String? {
        get {
          return snapshot["medicalAppointmentPatientFamilyName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
        }
      }

      public struct Patient: GraphQLSelectionSet {
        public static let possibleTypes = ["Patient"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
          GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var ssn: GraphQLID {
          get {
            return snapshot["ssn"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "ssn")
          }
        }

        public var givenName: String {
          get {
            return snapshot["givenName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "givenName")
          }
        }

        public var familyName: String {
          get {
            return snapshot["familyName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "familyName")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class CreateTodoMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateTodo($input: CreateTodoInput!, $condition: ModelTodoConditionInput) {\n  createTodo(input: $input, condition: $condition) {\n    __typename\n    content\n    id\n    createdAt\n    updatedAt\n    owner\n  }\n}"

  public var input: CreateTodoInput
  public var condition: ModelTodoConditionInput?

  public init(input: CreateTodoInput, condition: ModelTodoConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createTodo", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(CreateTodo.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createTodo: CreateTodo? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "createTodo": createTodo.flatMap { $0.snapshot }])
    }

    public var createTodo: CreateTodo? {
      get {
        return (snapshot["createTodo"] as? Snapshot).flatMap { CreateTodo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createTodo")
      }
    }

    public struct CreateTodo: GraphQLSelectionSet {
      public static let possibleTypes = ["Todo"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(content: String? = nil, id: GraphQLID, createdAt: String, updatedAt: String, owner: String? = nil) {
        self.init(snapshot: ["__typename": "Todo", "content": content, "id": id, "createdAt": createdAt, "updatedAt": updatedAt, "owner": owner])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var content: String? {
        get {
          return snapshot["content"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var owner: String? {
        get {
          return snapshot["owner"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }
    }
  }
}

public final class UpdateTodoMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdateTodo($input: UpdateTodoInput!, $condition: ModelTodoConditionInput) {\n  updateTodo(input: $input, condition: $condition) {\n    __typename\n    content\n    id\n    createdAt\n    updatedAt\n    owner\n  }\n}"

  public var input: UpdateTodoInput
  public var condition: ModelTodoConditionInput?

  public init(input: UpdateTodoInput, condition: ModelTodoConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateTodo", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(UpdateTodo.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updateTodo: UpdateTodo? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "updateTodo": updateTodo.flatMap { $0.snapshot }])
    }

    public var updateTodo: UpdateTodo? {
      get {
        return (snapshot["updateTodo"] as? Snapshot).flatMap { UpdateTodo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "updateTodo")
      }
    }

    public struct UpdateTodo: GraphQLSelectionSet {
      public static let possibleTypes = ["Todo"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(content: String? = nil, id: GraphQLID, createdAt: String, updatedAt: String, owner: String? = nil) {
        self.init(snapshot: ["__typename": "Todo", "content": content, "id": id, "createdAt": createdAt, "updatedAt": updatedAt, "owner": owner])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var content: String? {
        get {
          return snapshot["content"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var owner: String? {
        get {
          return snapshot["owner"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }
    }
  }
}

public final class DeleteTodoMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteTodo($input: DeleteTodoInput!, $condition: ModelTodoConditionInput) {\n  deleteTodo(input: $input, condition: $condition) {\n    __typename\n    content\n    id\n    createdAt\n    updatedAt\n    owner\n  }\n}"

  public var input: DeleteTodoInput
  public var condition: ModelTodoConditionInput?

  public init(input: DeleteTodoInput, condition: ModelTodoConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteTodo", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(DeleteTodo.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deleteTodo: DeleteTodo? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deleteTodo": deleteTodo.flatMap { $0.snapshot }])
    }

    public var deleteTodo: DeleteTodo? {
      get {
        return (snapshot["deleteTodo"] as? Snapshot).flatMap { DeleteTodo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deleteTodo")
      }
    }

    public struct DeleteTodo: GraphQLSelectionSet {
      public static let possibleTypes = ["Todo"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(content: String? = nil, id: GraphQLID, createdAt: String, updatedAt: String, owner: String? = nil) {
        self.init(snapshot: ["__typename": "Todo", "content": content, "id": id, "createdAt": createdAt, "updatedAt": updatedAt, "owner": owner])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var content: String? {
        get {
          return snapshot["content"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var owner: String? {
        get {
          return snapshot["owner"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }
    }
  }
}

public final class GetPatientQuery: GraphQLQuery {
  public static let operationString =
    "query GetPatient($ssn: ID!, $givenName: String!, $familyName: String!) {\n  getPatient(ssn: $ssn, givenName: $givenName, familyName: $familyName) {\n    __typename\n    ssn\n    givenName\n    familyName\n    createdAt\n    updatedAt\n  }\n}"

  public var ssn: GraphQLID
  public var givenName: String
  public var familyName: String

  public init(ssn: GraphQLID, givenName: String, familyName: String) {
    self.ssn = ssn
    self.givenName = givenName
    self.familyName = familyName
  }

  public var variables: GraphQLMap? {
    return ["ssn": ssn, "givenName": givenName, "familyName": familyName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getPatient", arguments: ["ssn": GraphQLVariable("ssn"), "givenName": GraphQLVariable("givenName"), "familyName": GraphQLVariable("familyName")], type: .object(GetPatient.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getPatient: GetPatient? = nil) {
      self.init(snapshot: ["__typename": "Query", "getPatient": getPatient.flatMap { $0.snapshot }])
    }

    public var getPatient: GetPatient? {
      get {
        return (snapshot["getPatient"] as? Snapshot).flatMap { GetPatient(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getPatient")
      }
    }

    public struct GetPatient: GraphQLSelectionSet {
      public static let possibleTypes = ["Patient"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ssn: GraphQLID {
        get {
          return snapshot["ssn"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "ssn")
        }
      }

      public var givenName: String {
        get {
          return snapshot["givenName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "givenName")
        }
      }

      public var familyName: String {
        get {
          return snapshot["familyName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "familyName")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class ListPatientsQuery: GraphQLQuery {
  public static let operationString =
    "query ListPatients($ssn: ID, $givenNameFamilyName: ModelPatientPrimaryCompositeKeyConditionInput, $filter: ModelPatientFilterInput, $limit: Int, $nextToken: String, $sortDirection: ModelSortDirection) {\n  listPatients(\n    ssn: $ssn\n    givenNameFamilyName: $givenNameFamilyName\n    filter: $filter\n    limit: $limit\n    nextToken: $nextToken\n    sortDirection: $sortDirection\n  ) {\n    __typename\n    items {\n      __typename\n      ssn\n      givenName\n      familyName\n      createdAt\n      updatedAt\n    }\n    nextToken\n  }\n}"

  public var ssn: GraphQLID?
  public var givenNameFamilyName: ModelPatientPrimaryCompositeKeyConditionInput?
  public var filter: ModelPatientFilterInput?
  public var limit: Int?
  public var nextToken: String?
  public var sortDirection: ModelSortDirection?

  public init(ssn: GraphQLID? = nil, givenNameFamilyName: ModelPatientPrimaryCompositeKeyConditionInput? = nil, filter: ModelPatientFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil, sortDirection: ModelSortDirection? = nil) {
    self.ssn = ssn
    self.givenNameFamilyName = givenNameFamilyName
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
    self.sortDirection = sortDirection
  }

  public var variables: GraphQLMap? {
    return ["ssn": ssn, "givenNameFamilyName": givenNameFamilyName, "filter": filter, "limit": limit, "nextToken": nextToken, "sortDirection": sortDirection]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listPatients", arguments: ["ssn": GraphQLVariable("ssn"), "givenNameFamilyName": GraphQLVariable("givenNameFamilyName"), "filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken"), "sortDirection": GraphQLVariable("sortDirection")], type: .object(ListPatient.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listPatients: ListPatient? = nil) {
      self.init(snapshot: ["__typename": "Query", "listPatients": listPatients.flatMap { $0.snapshot }])
    }

    public var listPatients: ListPatient? {
      get {
        return (snapshot["listPatients"] as? Snapshot).flatMap { ListPatient(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "listPatients")
      }
    }

    public struct ListPatient: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelPatientConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelPatientConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Patient"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
          GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var ssn: GraphQLID {
          get {
            return snapshot["ssn"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "ssn")
          }
        }

        public var givenName: String {
          get {
            return snapshot["givenName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "givenName")
          }
        }

        public var familyName: String {
          get {
            return snapshot["familyName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "familyName")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class GetMedicalAppointmentQuery: GraphQLQuery {
  public static let operationString =
    "query GetMedicalAppointment($appointmentReference: ID!) {\n  getMedicalAppointment(appointmentReference: $appointmentReference) {\n    __typename\n    appointmentReference\n    patient {\n      __typename\n      ssn\n      givenName\n      familyName\n      createdAt\n      updatedAt\n    }\n    provider\n    date\n    createdAt\n    updatedAt\n    medicalAppointmentPatientSsn\n    medicalAppointmentPatientGivenName\n    medicalAppointmentPatientFamilyName\n  }\n}"

  public var appointmentReference: GraphQLID

  public init(appointmentReference: GraphQLID) {
    self.appointmentReference = appointmentReference
  }

  public var variables: GraphQLMap? {
    return ["appointmentReference": appointmentReference]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getMedicalAppointment", arguments: ["appointmentReference": GraphQLVariable("appointmentReference")], type: .object(GetMedicalAppointment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getMedicalAppointment: GetMedicalAppointment? = nil) {
      self.init(snapshot: ["__typename": "Query", "getMedicalAppointment": getMedicalAppointment.flatMap { $0.snapshot }])
    }

    public var getMedicalAppointment: GetMedicalAppointment? {
      get {
        return (snapshot["getMedicalAppointment"] as? Snapshot).flatMap { GetMedicalAppointment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getMedicalAppointment")
      }
    }

    public struct GetMedicalAppointment: GraphQLSelectionSet {
      public static let possibleTypes = ["MedicalAppointment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("appointmentReference", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("patient", type: .object(Patient.selections)),
        GraphQLField("provider", type: .scalar(String.self)),
        GraphQLField("date", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("medicalAppointmentPatientSsn", type: .scalar(GraphQLID.self)),
        GraphQLField("medicalAppointmentPatientGivenName", type: .scalar(String.self)),
        GraphQLField("medicalAppointmentPatientFamilyName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(appointmentReference: GraphQLID, patient: Patient? = nil, provider: String? = nil, date: String? = nil, createdAt: String, updatedAt: String, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
        self.init(snapshot: ["__typename": "MedicalAppointment", "appointmentReference": appointmentReference, "patient": patient.flatMap { $0.snapshot }, "provider": provider, "date": date, "createdAt": createdAt, "updatedAt": updatedAt, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var appointmentReference: GraphQLID {
        get {
          return snapshot["appointmentReference"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "appointmentReference")
        }
      }

      public var patient: Patient? {
        get {
          return (snapshot["patient"] as? Snapshot).flatMap { Patient(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "patient")
        }
      }

      public var provider: String? {
        get {
          return snapshot["provider"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "provider")
        }
      }

      public var date: String? {
        get {
          return snapshot["date"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var medicalAppointmentPatientSsn: GraphQLID? {
        get {
          return snapshot["medicalAppointmentPatientSsn"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
        }
      }

      public var medicalAppointmentPatientGivenName: String? {
        get {
          return snapshot["medicalAppointmentPatientGivenName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
        }
      }

      public var medicalAppointmentPatientFamilyName: String? {
        get {
          return snapshot["medicalAppointmentPatientFamilyName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
        }
      }

      public struct Patient: GraphQLSelectionSet {
        public static let possibleTypes = ["Patient"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
          GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var ssn: GraphQLID {
          get {
            return snapshot["ssn"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "ssn")
          }
        }

        public var givenName: String {
          get {
            return snapshot["givenName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "givenName")
          }
        }

        public var familyName: String {
          get {
            return snapshot["familyName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "familyName")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class ListMedicalAppointmentsQuery: GraphQLQuery {
  public static let operationString =
    "query ListMedicalAppointments($appointmentReference: ID, $filter: ModelMedicalAppointmentFilterInput, $limit: Int, $nextToken: String, $sortDirection: ModelSortDirection) {\n  listMedicalAppointments(\n    appointmentReference: $appointmentReference\n    filter: $filter\n    limit: $limit\n    nextToken: $nextToken\n    sortDirection: $sortDirection\n  ) {\n    __typename\n    items {\n      __typename\n      appointmentReference\n      provider\n      date\n      createdAt\n      updatedAt\n      medicalAppointmentPatientSsn\n      medicalAppointmentPatientGivenName\n      medicalAppointmentPatientFamilyName\n    }\n    nextToken\n  }\n}"

  public var appointmentReference: GraphQLID?
  public var filter: ModelMedicalAppointmentFilterInput?
  public var limit: Int?
  public var nextToken: String?
  public var sortDirection: ModelSortDirection?

  public init(appointmentReference: GraphQLID? = nil, filter: ModelMedicalAppointmentFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil, sortDirection: ModelSortDirection? = nil) {
    self.appointmentReference = appointmentReference
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
    self.sortDirection = sortDirection
  }

  public var variables: GraphQLMap? {
    return ["appointmentReference": appointmentReference, "filter": filter, "limit": limit, "nextToken": nextToken, "sortDirection": sortDirection]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listMedicalAppointments", arguments: ["appointmentReference": GraphQLVariable("appointmentReference"), "filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken"), "sortDirection": GraphQLVariable("sortDirection")], type: .object(ListMedicalAppointment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listMedicalAppointments: ListMedicalAppointment? = nil) {
      self.init(snapshot: ["__typename": "Query", "listMedicalAppointments": listMedicalAppointments.flatMap { $0.snapshot }])
    }

    public var listMedicalAppointments: ListMedicalAppointment? {
      get {
        return (snapshot["listMedicalAppointments"] as? Snapshot).flatMap { ListMedicalAppointment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "listMedicalAppointments")
      }
    }

    public struct ListMedicalAppointment: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelMedicalAppointmentConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelMedicalAppointmentConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["MedicalAppointment"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("appointmentReference", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("provider", type: .scalar(String.self)),
          GraphQLField("date", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("medicalAppointmentPatientSsn", type: .scalar(GraphQLID.self)),
          GraphQLField("medicalAppointmentPatientGivenName", type: .scalar(String.self)),
          GraphQLField("medicalAppointmentPatientFamilyName", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(appointmentReference: GraphQLID, provider: String? = nil, date: String? = nil, createdAt: String, updatedAt: String, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
          self.init(snapshot: ["__typename": "MedicalAppointment", "appointmentReference": appointmentReference, "provider": provider, "date": date, "createdAt": createdAt, "updatedAt": updatedAt, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var appointmentReference: GraphQLID {
          get {
            return snapshot["appointmentReference"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "appointmentReference")
          }
        }

        public var provider: String? {
          get {
            return snapshot["provider"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "provider")
          }
        }

        public var date: String? {
          get {
            return snapshot["date"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "date")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }

        public var medicalAppointmentPatientSsn: GraphQLID? {
          get {
            return snapshot["medicalAppointmentPatientSsn"] as? GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
          }
        }

        public var medicalAppointmentPatientGivenName: String? {
          get {
            return snapshot["medicalAppointmentPatientGivenName"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
          }
        }

        public var medicalAppointmentPatientFamilyName: String? {
          get {
            return snapshot["medicalAppointmentPatientFamilyName"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
          }
        }
      }
    }
  }
}

public final class GetTodoQuery: GraphQLQuery {
  public static let operationString =
    "query GetTodo($id: ID!) {\n  getTodo(id: $id) {\n    __typename\n    content\n    id\n    createdAt\n    updatedAt\n    owner\n  }\n}"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getTodo", arguments: ["id": GraphQLVariable("id")], type: .object(GetTodo.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getTodo: GetTodo? = nil) {
      self.init(snapshot: ["__typename": "Query", "getTodo": getTodo.flatMap { $0.snapshot }])
    }

    public var getTodo: GetTodo? {
      get {
        return (snapshot["getTodo"] as? Snapshot).flatMap { GetTodo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getTodo")
      }
    }

    public struct GetTodo: GraphQLSelectionSet {
      public static let possibleTypes = ["Todo"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(content: String? = nil, id: GraphQLID, createdAt: String, updatedAt: String, owner: String? = nil) {
        self.init(snapshot: ["__typename": "Todo", "content": content, "id": id, "createdAt": createdAt, "updatedAt": updatedAt, "owner": owner])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var content: String? {
        get {
          return snapshot["content"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var owner: String? {
        get {
          return snapshot["owner"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }
    }
  }
}

public final class ListTodosQuery: GraphQLQuery {
  public static let operationString =
    "query ListTodos($filter: ModelTodoFilterInput, $limit: Int, $nextToken: String) {\n  listTodos(filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      content\n      id\n      createdAt\n      updatedAt\n      owner\n    }\n    nextToken\n  }\n}"

  public var filter: ModelTodoFilterInput?
  public var limit: Int?
  public var nextToken: String?

  public init(filter: ModelTodoFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["filter": filter, "limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listTodos", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(ListTodo.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listTodos: ListTodo? = nil) {
      self.init(snapshot: ["__typename": "Query", "listTodos": listTodos.flatMap { $0.snapshot }])
    }

    public var listTodos: ListTodo? {
      get {
        return (snapshot["listTodos"] as? Snapshot).flatMap { ListTodo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "listTodos")
      }
    }

    public struct ListTodo: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelTodoConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelTodoConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Todo"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("content", type: .scalar(String.self)),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("owner", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(content: String? = nil, id: GraphQLID, createdAt: String, updatedAt: String, owner: String? = nil) {
          self.init(snapshot: ["__typename": "Todo", "content": content, "id": id, "createdAt": createdAt, "updatedAt": updatedAt, "owner": owner])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var content: String? {
          get {
            return snapshot["content"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "content")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }

        public var owner: String? {
          get {
            return snapshot["owner"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }
      }
    }
  }
}

public final class OnCreatePatientSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreatePatient($filter: ModelSubscriptionPatientFilterInput) {\n  onCreatePatient(filter: $filter) {\n    __typename\n    ssn\n    givenName\n    familyName\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionPatientFilterInput?

  public init(filter: ModelSubscriptionPatientFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onCreatePatient", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnCreatePatient.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onCreatePatient: OnCreatePatient? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onCreatePatient": onCreatePatient.flatMap { $0.snapshot }])
    }

    public var onCreatePatient: OnCreatePatient? {
      get {
        return (snapshot["onCreatePatient"] as? Snapshot).flatMap { OnCreatePatient(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onCreatePatient")
      }
    }

    public struct OnCreatePatient: GraphQLSelectionSet {
      public static let possibleTypes = ["Patient"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ssn: GraphQLID {
        get {
          return snapshot["ssn"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "ssn")
        }
      }

      public var givenName: String {
        get {
          return snapshot["givenName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "givenName")
        }
      }

      public var familyName: String {
        get {
          return snapshot["familyName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "familyName")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnUpdatePatientSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdatePatient($filter: ModelSubscriptionPatientFilterInput) {\n  onUpdatePatient(filter: $filter) {\n    __typename\n    ssn\n    givenName\n    familyName\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionPatientFilterInput?

  public init(filter: ModelSubscriptionPatientFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdatePatient", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnUpdatePatient.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdatePatient: OnUpdatePatient? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdatePatient": onUpdatePatient.flatMap { $0.snapshot }])
    }

    public var onUpdatePatient: OnUpdatePatient? {
      get {
        return (snapshot["onUpdatePatient"] as? Snapshot).flatMap { OnUpdatePatient(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdatePatient")
      }
    }

    public struct OnUpdatePatient: GraphQLSelectionSet {
      public static let possibleTypes = ["Patient"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ssn: GraphQLID {
        get {
          return snapshot["ssn"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "ssn")
        }
      }

      public var givenName: String {
        get {
          return snapshot["givenName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "givenName")
        }
      }

      public var familyName: String {
        get {
          return snapshot["familyName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "familyName")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnDeletePatientSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnDeletePatient($filter: ModelSubscriptionPatientFilterInput) {\n  onDeletePatient(filter: $filter) {\n    __typename\n    ssn\n    givenName\n    familyName\n    createdAt\n    updatedAt\n  }\n}"

  public var filter: ModelSubscriptionPatientFilterInput?

  public init(filter: ModelSubscriptionPatientFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onDeletePatient", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnDeletePatient.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onDeletePatient: OnDeletePatient? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onDeletePatient": onDeletePatient.flatMap { $0.snapshot }])
    }

    public var onDeletePatient: OnDeletePatient? {
      get {
        return (snapshot["onDeletePatient"] as? Snapshot).flatMap { OnDeletePatient(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onDeletePatient")
      }
    }

    public struct OnDeletePatient: GraphQLSelectionSet {
      public static let possibleTypes = ["Patient"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ssn: GraphQLID {
        get {
          return snapshot["ssn"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "ssn")
        }
      }

      public var givenName: String {
        get {
          return snapshot["givenName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "givenName")
        }
      }

      public var familyName: String {
        get {
          return snapshot["familyName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "familyName")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnCreateMedicalAppointmentSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreateMedicalAppointment($filter: ModelSubscriptionMedicalAppointmentFilterInput) {\n  onCreateMedicalAppointment(filter: $filter) {\n    __typename\n    appointmentReference\n    patient {\n      __typename\n      ssn\n      givenName\n      familyName\n      createdAt\n      updatedAt\n    }\n    provider\n    date\n    createdAt\n    updatedAt\n    medicalAppointmentPatientSsn\n    medicalAppointmentPatientGivenName\n    medicalAppointmentPatientFamilyName\n  }\n}"

  public var filter: ModelSubscriptionMedicalAppointmentFilterInput?

  public init(filter: ModelSubscriptionMedicalAppointmentFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onCreateMedicalAppointment", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnCreateMedicalAppointment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onCreateMedicalAppointment: OnCreateMedicalAppointment? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onCreateMedicalAppointment": onCreateMedicalAppointment.flatMap { $0.snapshot }])
    }

    public var onCreateMedicalAppointment: OnCreateMedicalAppointment? {
      get {
        return (snapshot["onCreateMedicalAppointment"] as? Snapshot).flatMap { OnCreateMedicalAppointment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onCreateMedicalAppointment")
      }
    }

    public struct OnCreateMedicalAppointment: GraphQLSelectionSet {
      public static let possibleTypes = ["MedicalAppointment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("appointmentReference", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("patient", type: .object(Patient.selections)),
        GraphQLField("provider", type: .scalar(String.self)),
        GraphQLField("date", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("medicalAppointmentPatientSsn", type: .scalar(GraphQLID.self)),
        GraphQLField("medicalAppointmentPatientGivenName", type: .scalar(String.self)),
        GraphQLField("medicalAppointmentPatientFamilyName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(appointmentReference: GraphQLID, patient: Patient? = nil, provider: String? = nil, date: String? = nil, createdAt: String, updatedAt: String, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
        self.init(snapshot: ["__typename": "MedicalAppointment", "appointmentReference": appointmentReference, "patient": patient.flatMap { $0.snapshot }, "provider": provider, "date": date, "createdAt": createdAt, "updatedAt": updatedAt, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var appointmentReference: GraphQLID {
        get {
          return snapshot["appointmentReference"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "appointmentReference")
        }
      }

      public var patient: Patient? {
        get {
          return (snapshot["patient"] as? Snapshot).flatMap { Patient(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "patient")
        }
      }

      public var provider: String? {
        get {
          return snapshot["provider"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "provider")
        }
      }

      public var date: String? {
        get {
          return snapshot["date"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var medicalAppointmentPatientSsn: GraphQLID? {
        get {
          return snapshot["medicalAppointmentPatientSsn"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
        }
      }

      public var medicalAppointmentPatientGivenName: String? {
        get {
          return snapshot["medicalAppointmentPatientGivenName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
        }
      }

      public var medicalAppointmentPatientFamilyName: String? {
        get {
          return snapshot["medicalAppointmentPatientFamilyName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
        }
      }

      public struct Patient: GraphQLSelectionSet {
        public static let possibleTypes = ["Patient"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
          GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var ssn: GraphQLID {
          get {
            return snapshot["ssn"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "ssn")
          }
        }

        public var givenName: String {
          get {
            return snapshot["givenName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "givenName")
          }
        }

        public var familyName: String {
          get {
            return snapshot["familyName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "familyName")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class OnUpdateMedicalAppointmentSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdateMedicalAppointment($filter: ModelSubscriptionMedicalAppointmentFilterInput) {\n  onUpdateMedicalAppointment(filter: $filter) {\n    __typename\n    appointmentReference\n    patient {\n      __typename\n      ssn\n      givenName\n      familyName\n      createdAt\n      updatedAt\n    }\n    provider\n    date\n    createdAt\n    updatedAt\n    medicalAppointmentPatientSsn\n    medicalAppointmentPatientGivenName\n    medicalAppointmentPatientFamilyName\n  }\n}"

  public var filter: ModelSubscriptionMedicalAppointmentFilterInput?

  public init(filter: ModelSubscriptionMedicalAppointmentFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdateMedicalAppointment", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnUpdateMedicalAppointment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdateMedicalAppointment: OnUpdateMedicalAppointment? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdateMedicalAppointment": onUpdateMedicalAppointment.flatMap { $0.snapshot }])
    }

    public var onUpdateMedicalAppointment: OnUpdateMedicalAppointment? {
      get {
        return (snapshot["onUpdateMedicalAppointment"] as? Snapshot).flatMap { OnUpdateMedicalAppointment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdateMedicalAppointment")
      }
    }

    public struct OnUpdateMedicalAppointment: GraphQLSelectionSet {
      public static let possibleTypes = ["MedicalAppointment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("appointmentReference", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("patient", type: .object(Patient.selections)),
        GraphQLField("provider", type: .scalar(String.self)),
        GraphQLField("date", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("medicalAppointmentPatientSsn", type: .scalar(GraphQLID.self)),
        GraphQLField("medicalAppointmentPatientGivenName", type: .scalar(String.self)),
        GraphQLField("medicalAppointmentPatientFamilyName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(appointmentReference: GraphQLID, patient: Patient? = nil, provider: String? = nil, date: String? = nil, createdAt: String, updatedAt: String, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
        self.init(snapshot: ["__typename": "MedicalAppointment", "appointmentReference": appointmentReference, "patient": patient.flatMap { $0.snapshot }, "provider": provider, "date": date, "createdAt": createdAt, "updatedAt": updatedAt, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var appointmentReference: GraphQLID {
        get {
          return snapshot["appointmentReference"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "appointmentReference")
        }
      }

      public var patient: Patient? {
        get {
          return (snapshot["patient"] as? Snapshot).flatMap { Patient(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "patient")
        }
      }

      public var provider: String? {
        get {
          return snapshot["provider"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "provider")
        }
      }

      public var date: String? {
        get {
          return snapshot["date"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var medicalAppointmentPatientSsn: GraphQLID? {
        get {
          return snapshot["medicalAppointmentPatientSsn"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
        }
      }

      public var medicalAppointmentPatientGivenName: String? {
        get {
          return snapshot["medicalAppointmentPatientGivenName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
        }
      }

      public var medicalAppointmentPatientFamilyName: String? {
        get {
          return snapshot["medicalAppointmentPatientFamilyName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
        }
      }

      public struct Patient: GraphQLSelectionSet {
        public static let possibleTypes = ["Patient"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
          GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var ssn: GraphQLID {
          get {
            return snapshot["ssn"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "ssn")
          }
        }

        public var givenName: String {
          get {
            return snapshot["givenName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "givenName")
          }
        }

        public var familyName: String {
          get {
            return snapshot["familyName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "familyName")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class OnDeleteMedicalAppointmentSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnDeleteMedicalAppointment($filter: ModelSubscriptionMedicalAppointmentFilterInput) {\n  onDeleteMedicalAppointment(filter: $filter) {\n    __typename\n    appointmentReference\n    patient {\n      __typename\n      ssn\n      givenName\n      familyName\n      createdAt\n      updatedAt\n    }\n    provider\n    date\n    createdAt\n    updatedAt\n    medicalAppointmentPatientSsn\n    medicalAppointmentPatientGivenName\n    medicalAppointmentPatientFamilyName\n  }\n}"

  public var filter: ModelSubscriptionMedicalAppointmentFilterInput?

  public init(filter: ModelSubscriptionMedicalAppointmentFilterInput? = nil) {
    self.filter = filter
  }

  public var variables: GraphQLMap? {
    return ["filter": filter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onDeleteMedicalAppointment", arguments: ["filter": GraphQLVariable("filter")], type: .object(OnDeleteMedicalAppointment.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onDeleteMedicalAppointment: OnDeleteMedicalAppointment? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onDeleteMedicalAppointment": onDeleteMedicalAppointment.flatMap { $0.snapshot }])
    }

    public var onDeleteMedicalAppointment: OnDeleteMedicalAppointment? {
      get {
        return (snapshot["onDeleteMedicalAppointment"] as? Snapshot).flatMap { OnDeleteMedicalAppointment(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onDeleteMedicalAppointment")
      }
    }

    public struct OnDeleteMedicalAppointment: GraphQLSelectionSet {
      public static let possibleTypes = ["MedicalAppointment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("appointmentReference", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("patient", type: .object(Patient.selections)),
        GraphQLField("provider", type: .scalar(String.self)),
        GraphQLField("date", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("medicalAppointmentPatientSsn", type: .scalar(GraphQLID.self)),
        GraphQLField("medicalAppointmentPatientGivenName", type: .scalar(String.self)),
        GraphQLField("medicalAppointmentPatientFamilyName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(appointmentReference: GraphQLID, patient: Patient? = nil, provider: String? = nil, date: String? = nil, createdAt: String, updatedAt: String, medicalAppointmentPatientSsn: GraphQLID? = nil, medicalAppointmentPatientGivenName: String? = nil, medicalAppointmentPatientFamilyName: String? = nil) {
        self.init(snapshot: ["__typename": "MedicalAppointment", "appointmentReference": appointmentReference, "patient": patient.flatMap { $0.snapshot }, "provider": provider, "date": date, "createdAt": createdAt, "updatedAt": updatedAt, "medicalAppointmentPatientSsn": medicalAppointmentPatientSsn, "medicalAppointmentPatientGivenName": medicalAppointmentPatientGivenName, "medicalAppointmentPatientFamilyName": medicalAppointmentPatientFamilyName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var appointmentReference: GraphQLID {
        get {
          return snapshot["appointmentReference"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "appointmentReference")
        }
      }

      public var patient: Patient? {
        get {
          return (snapshot["patient"] as? Snapshot).flatMap { Patient(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "patient")
        }
      }

      public var provider: String? {
        get {
          return snapshot["provider"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "provider")
        }
      }

      public var date: String? {
        get {
          return snapshot["date"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var medicalAppointmentPatientSsn: GraphQLID? {
        get {
          return snapshot["medicalAppointmentPatientSsn"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientSsn")
        }
      }

      public var medicalAppointmentPatientGivenName: String? {
        get {
          return snapshot["medicalAppointmentPatientGivenName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientGivenName")
        }
      }

      public var medicalAppointmentPatientFamilyName: String? {
        get {
          return snapshot["medicalAppointmentPatientFamilyName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "medicalAppointmentPatientFamilyName")
        }
      }

      public struct Patient: GraphQLSelectionSet {
        public static let possibleTypes = ["Patient"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ssn", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
          GraphQLField("familyName", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(ssn: GraphQLID, givenName: String, familyName: String, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Patient", "ssn": ssn, "givenName": givenName, "familyName": familyName, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var ssn: GraphQLID {
          get {
            return snapshot["ssn"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "ssn")
          }
        }

        public var givenName: String {
          get {
            return snapshot["givenName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "givenName")
          }
        }

        public var familyName: String {
          get {
            return snapshot["familyName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "familyName")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class OnCreateTodoSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreateTodo($filter: ModelSubscriptionTodoFilterInput, $owner: String) {\n  onCreateTodo(filter: $filter, owner: $owner) {\n    __typename\n    content\n    id\n    createdAt\n    updatedAt\n    owner\n  }\n}"

  public var filter: ModelSubscriptionTodoFilterInput?
  public var owner: String?

  public init(filter: ModelSubscriptionTodoFilterInput? = nil, owner: String? = nil) {
    self.filter = filter
    self.owner = owner
  }

  public var variables: GraphQLMap? {
    return ["filter": filter, "owner": owner]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onCreateTodo", arguments: ["filter": GraphQLVariable("filter"), "owner": GraphQLVariable("owner")], type: .object(OnCreateTodo.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onCreateTodo: OnCreateTodo? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onCreateTodo": onCreateTodo.flatMap { $0.snapshot }])
    }

    public var onCreateTodo: OnCreateTodo? {
      get {
        return (snapshot["onCreateTodo"] as? Snapshot).flatMap { OnCreateTodo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onCreateTodo")
      }
    }

    public struct OnCreateTodo: GraphQLSelectionSet {
      public static let possibleTypes = ["Todo"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(content: String? = nil, id: GraphQLID, createdAt: String, updatedAt: String, owner: String? = nil) {
        self.init(snapshot: ["__typename": "Todo", "content": content, "id": id, "createdAt": createdAt, "updatedAt": updatedAt, "owner": owner])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var content: String? {
        get {
          return snapshot["content"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var owner: String? {
        get {
          return snapshot["owner"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }
    }
  }
}

public final class OnUpdateTodoSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdateTodo($filter: ModelSubscriptionTodoFilterInput, $owner: String) {\n  onUpdateTodo(filter: $filter, owner: $owner) {\n    __typename\n    content\n    id\n    createdAt\n    updatedAt\n    owner\n  }\n}"

  public var filter: ModelSubscriptionTodoFilterInput?
  public var owner: String?

  public init(filter: ModelSubscriptionTodoFilterInput? = nil, owner: String? = nil) {
    self.filter = filter
    self.owner = owner
  }

  public var variables: GraphQLMap? {
    return ["filter": filter, "owner": owner]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdateTodo", arguments: ["filter": GraphQLVariable("filter"), "owner": GraphQLVariable("owner")], type: .object(OnUpdateTodo.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdateTodo: OnUpdateTodo? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdateTodo": onUpdateTodo.flatMap { $0.snapshot }])
    }

    public var onUpdateTodo: OnUpdateTodo? {
      get {
        return (snapshot["onUpdateTodo"] as? Snapshot).flatMap { OnUpdateTodo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdateTodo")
      }
    }

    public struct OnUpdateTodo: GraphQLSelectionSet {
      public static let possibleTypes = ["Todo"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(content: String? = nil, id: GraphQLID, createdAt: String, updatedAt: String, owner: String? = nil) {
        self.init(snapshot: ["__typename": "Todo", "content": content, "id": id, "createdAt": createdAt, "updatedAt": updatedAt, "owner": owner])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var content: String? {
        get {
          return snapshot["content"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var owner: String? {
        get {
          return snapshot["owner"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }
    }
  }
}

public final class OnDeleteTodoSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnDeleteTodo($filter: ModelSubscriptionTodoFilterInput, $owner: String) {\n  onDeleteTodo(filter: $filter, owner: $owner) {\n    __typename\n    content\n    id\n    createdAt\n    updatedAt\n    owner\n  }\n}"

  public var filter: ModelSubscriptionTodoFilterInput?
  public var owner: String?

  public init(filter: ModelSubscriptionTodoFilterInput? = nil, owner: String? = nil) {
    self.filter = filter
    self.owner = owner
  }

  public var variables: GraphQLMap? {
    return ["filter": filter, "owner": owner]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onDeleteTodo", arguments: ["filter": GraphQLVariable("filter"), "owner": GraphQLVariable("owner")], type: .object(OnDeleteTodo.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onDeleteTodo: OnDeleteTodo? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onDeleteTodo": onDeleteTodo.flatMap { $0.snapshot }])
    }

    public var onDeleteTodo: OnDeleteTodo? {
      get {
        return (snapshot["onDeleteTodo"] as? Snapshot).flatMap { OnDeleteTodo(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onDeleteTodo")
      }
    }

    public struct OnDeleteTodo: GraphQLSelectionSet {
      public static let possibleTypes = ["Todo"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(content: String? = nil, id: GraphQLID, createdAt: String, updatedAt: String, owner: String? = nil) {
        self.init(snapshot: ["__typename": "Todo", "content": content, "id": id, "createdAt": createdAt, "updatedAt": updatedAt, "owner": owner])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var content: String? {
        get {
          return snapshot["content"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "content")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var owner: String? {
        get {
          return snapshot["owner"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }
    }
  }
}