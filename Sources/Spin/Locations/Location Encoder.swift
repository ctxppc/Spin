// Spin © 2019 Constantino Tsarouhas

import DepthKit

final class LocationEncoder : Encoder {
	
	/// Converts given location to a path.
	static func path<Location : LocationProtocol>(from location: Location) throws -> Path {
		let encoder = Self()
		try location.encode(to: encoder)
		return Location.pathComponents.map { component in
			switch component {
				case .literal(let literal):	return literal
				case .parameter(let key):	return encoder[key]
			}
		}
	}
	
	// See protocol.
	let codingPath = [CodingKey]()
	
	// See protocol.
	let userInfo = [CodingUserInfoKey : Any]()
	
	/// The encoded values, keyed by the respective coding key's string value.
	private var valuesByKey = [String : String]()
	
	fileprivate subscript <Key : CodingKey>(key: Key) -> String {
		get { valuesByKey[key.stringValue] !! "The location expects a value encoded for \(key)." }
		set { valuesByKey[key.stringValue] = newValue }
	}
	
	// See protocol.
	func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
		.init(KeyedLocationEncodingContainer(encoder: self))
	}
	
	// See protocol.
	func unkeyedContainer() -> UnkeyedEncodingContainer {
		fatalError("Unkeyed encoding is not supported for locations")
	}
	
	// See protocol.
	func singleValueContainer() -> SingleValueEncodingContainer {
		fatalError("Single-value encoding is not supported for locations")
	}
	
}

struct KeyedLocationEncodingContainer<Key : CodingKey> : KeyedEncodingContainerProtocol {
	
	// See protocol.
	let codingPath = [CodingKey]()
	
	/// The location encoder.
	let encoder: LocationEncoder
	
	// See protocol.
	mutating func encodeNil(forKey key: Key) throws {
		encoder[key] = "nil"
	}
	
	// See protocol.
	mutating func encode(_ value: Bool, forKey key: Key) throws {
		encoder[key] = value ? "true" : "false"
	}
	
	// See protocol.
	mutating func encode(_ value: String, forKey key: Key) throws {
		encoder[key] = value
	}
	
	// See protocol.
	mutating func encode(_ value: Double, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: Float, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: Int, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: Int8, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: Int16, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: Int32, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: Int64, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: UInt, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: UInt8, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: UInt16, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: UInt32, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode(_ value: UInt64, forKey key: Key) throws {
		encoder[key] = String(value)
	}
	
	// See protocol.
	mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
		try value.encode(to: NestedLocationEncoder(parentEncoder: encoder, key: key))
	}
	
	// See protocol.
	mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
		fatalError("Nested encoding not supported for locations")
	}
	
	// See protocol.
	mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
		fatalError("Nested encoding not supported for locations")
	}
	
	// See protocol.
	mutating func superEncoder() -> Encoder {
		fatalError("Nested encoding not supported for locations")
	}
	
	// See protocol.
	mutating func superEncoder(forKey key: Key) -> Encoder {
		fatalError("Nested encoding not supported for locations")
	}
	
}

struct NestedLocationEncoder<Key : CodingKey> : Encoder {
	
	/// The parent location encoder.
	let parentEncoder: LocationEncoder
	
	/// The key whose associated value is being encoded.
	let key: Key
	
	var codingPath: [CodingKey] { [key] }
	
	let userInfo = [CodingUserInfoKey : Any]()
	
	func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
		fatalError("Nested encoding not supported for locations")
	}
	
	func unkeyedContainer() -> UnkeyedEncodingContainer {
		fatalError("Unkeyed encoding not supported for locations")
	}
	
	func singleValueContainer() -> SingleValueEncodingContainer {
		SingleValueLocationEncodingContainer(encoder: self)
	}
	
	fileprivate func encode(_ value: String) {
		parentEncoder[key] = value
	}
	
}

struct SingleValueLocationEncodingContainer<Key : CodingKey> : SingleValueEncodingContainer {
	
	// See protocol.
	var codingPath: [CodingKey] { [encoder.key] }
	
	/// The nested location encoder.
	let encoder: NestedLocationEncoder<Key>
	
	// See protocol.
	mutating func encodeNil() throws {
		encoder.encode("nil")
	}
	
	// See protocol.
	mutating func encode(_ value: Bool) throws {
		encoder.encode(value ? "true" : "false")
	}
	
	// See protocol.
	mutating func encode(_ value: String) throws {
		encoder.encode(value)
	}
	
	// See protocol.
	mutating func encode(_ value: Double) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: Float) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: Int) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: Int8) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: Int16) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: Int32) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: Int64) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: UInt) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: UInt8) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: UInt16) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: UInt32) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode(_ value: UInt64) throws {
		encoder.encode(String(value))
	}
	
	// See protocol.
	mutating func encode<T>(_ value: T) throws where T : Encodable {
		try value.encode(to: encoder)
	}
	
}
