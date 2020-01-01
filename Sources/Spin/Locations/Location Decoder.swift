// Spin © 2019 Constantino Tsarouhas

import DepthKit

struct LocationDecoder : Decoder {
	
	/// Converts given path to a location.
	///
	/// - Parameter path: An array of path elements. The root path `/` is represented by an empty array.
	static func location<Location : LocationProtocol, Path : Sequence>(ofType _: Location.Type = Location.self, from path: Path) throws -> Location where Path.Element == String {
		try Location(from:
			Self(valuesByKey:
				Dictionary(uniqueKeysWithValues:
					zip(Location.pathComponents, path).compactMap { pair -> (String, String)? in
						let (template, actual) = pair
						switch template {
							case .literal:				return nil
							case .parameter(let key):	return (key.stringValue, actual)
						}
					}
				)
			)
		)
	}
	
	// See protocol.
	let codingPath = [CodingKey]()
	
	// See protocol.
	let userInfo = [CodingUserInfoKey : Any]()
	
	let valuesByKey: [String : String]
	
	func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
		.init(KeyedLocationDecodingContainer(decoder: self))
	}
	
	func unkeyedContainer() throws -> UnkeyedDecodingContainer {
		fatalError("Unkeyed decoding is not supported for locations")
	}
	
	func singleValueContainer() throws -> SingleValueDecodingContainer {
		fatalError("Single-value decoding is not supported for locations")
	}
	
}

fileprivate struct KeyedLocationDecodingContainer<Key : CodingKey> : KeyedDecodingContainerProtocol {
	
	let codingPath = [CodingKey]()
	
	var allKeys: [Key] {
		decoder.valuesByKey.keys.compactMap(Key.init(stringValue:))
	}
	
	let decoder: LocationDecoder
	
	func contains(_ key: Key) -> Bool {
		decoder.valuesByKey.keys.contains(key.stringValue)
	}
	
	private func value(forKey key: Key) throws -> String {
		guard let value = decoder.valuesByKey[key.stringValue] else { throw DecodingError.keyNotFound(key, .init(codingPath: [], debugDescription: "Value missing for \(key)")) }
		return value
	}
	
	private func decodeValue<Value : LosslessStringConvertible>(forKey key: Key) throws -> Value {
		guard let value = Value(try value(forKey: key)) else { throw DecodingError.typeMismatch(Value.self, .init(codingPath: [], debugDescription: "Value for \(key) is not a \(Value.self)"))}
		return value
	}
	
	func decodeNil(forKey key: Key) throws -> Bool {
		try value(forKey: key) == "nil"
	}
	
	func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: String.Type, forKey key: Key) throws -> String {
		try value(forKey: key)
	}
	
	func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
		try decodeValue(forKey: key)
	}
	
	func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
		try decodeValue(forKey: key)
	}
	
	func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
		try T(from: NestedLocationDecoder(parentDecoder: decoder, key: key))
	}
	
	func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
		fatalError("Nested decoding is not supported for locations")
	}
	
	func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
		fatalError("Nested decoding is not supported for locations")
	}
	
	func superDecoder() throws -> Decoder {
		fatalError("Nested decoding is not supported for locations")
	}
	
	func superDecoder(forKey key: Key) throws -> Decoder {
		fatalError("Nested decoding is not supported for locations")
	}
	
}

fileprivate struct NestedLocationDecoder<Key : CodingKey> : Decoder {
	
	let parentDecoder: LocationDecoder
	
	let key: Key
	
	var codingPath: [CodingKey] { [key] }
	
	let userInfo = [CodingUserInfoKey : Any]()
	
	func decodeValue() throws -> String {
		guard let value = parentDecoder.valuesByKey[key.stringValue] else { throw DecodingError.keyNotFound(key, .init(codingPath: [], debugDescription: "Value missing for \(key)")) }
		return value
	}
	
	func decodeValue<Value : LosslessStringConvertible>() throws -> Value {
		guard let value = Value(try decodeValue()) else { throw DecodingError.typeMismatch(Value.self, .init(codingPath: [], debugDescription: "Value for \(key) is not a \(Value.self)"))}
		return value
	}
	
	func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
		fatalError("Nested decoding is not supported for locations")
	}
	
	func unkeyedContainer() throws -> UnkeyedDecodingContainer {
		fatalError("Unkeyed decoding is not supported for locations")
	}
	
	func singleValueContainer() throws -> SingleValueDecodingContainer {
		SingleValueLocationDecodingContainer(decoder: self)
	}
	
}

fileprivate struct SingleValueLocationDecodingContainer<Key : CodingKey> : SingleValueDecodingContainer {
	
	let decoder: NestedLocationDecoder<Key>
	
	var codingPath: [CodingKey] { [decoder.key] }
	
	func decodeNil() -> Bool {
		do {
			return try decoder.decodeValue() == "nil"
		} catch {
			return false
		}
	}
	
	func decode(_ type: Bool.Type) throws -> Bool {
		try decoder.decodeValue()
	}
	
	func decode(_ type: String.Type) throws -> String {
		try decoder.decodeValue()
	}
	
	func decode(_ type: Double.Type) throws -> Double {
		try decoder.decodeValue()
	}
	
	func decode(_ type: Float.Type) throws -> Float {
		try decoder.decodeValue()
	}
	
	func decode(_ type: Int.Type) throws -> Int {
		try decoder.decodeValue()
	}
	
	func decode(_ type: Int8.Type) throws -> Int8 {
		try decoder.decodeValue()
	}
	
	func decode(_ type: Int16.Type) throws -> Int16 {
		try decoder.decodeValue()
	}
	
	func decode(_ type: Int32.Type) throws -> Int32 {
		try decoder.decodeValue()
	}
	
	func decode(_ type: Int64.Type) throws -> Int64 {
		try decoder.decodeValue()
	}
	
	func decode(_ type: UInt.Type) throws -> UInt {
		try decoder.decodeValue()
	}
	
	func decode(_ type: UInt8.Type) throws -> UInt8 {
		try decoder.decodeValue()
	}
	
	func decode(_ type: UInt16.Type) throws -> UInt16 {
		try decoder.decodeValue()
	}
	
	func decode(_ type: UInt32.Type) throws -> UInt32 {
		try decoder.decodeValue()
	}
	
	func decode(_ type: UInt64.Type) throws -> UInt64 {
		try decoder.decodeValue()
	}
	
	func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
		try T(from: decoder)
	}
	
}
