// Spin © 2019 Constantino Tsarouhas

import Foundation

/// A value that can be used to retrieve a locatable component.
public protocol LocationProtocol : Codable {
	
	/// The type of coding keys when encoding and decoding instances of this type.
	associatedtype CodingKey : Swift.CodingKey
	
	/// The path components in locations of this type.
	static var pathComponents: [LocationPathComponent<CodingKey>] { get }
	
}

extension LocationProtocol {
	
	/// Returns `self` as a URL.
	///
	/// - Throws: An error if `self` can't be encoded.
	public func urlRepresentation(relativeTo baseURL: URL = URL(string: "/")!) throws -> URL {
		let path = try LocationEncoder.path(from: self)
		guard let last = path.last else { return baseURL }
		return path.lazy.dropLast().reduce(baseURL) {
			$0.appendingPathComponent($1, isDirectory: true)
		}.appendingPathComponent(last, isDirectory: false)
	}
	
}

public enum LocationPathComponent<Key : CodingKey> {
	case literal(String)
	case parameter(key: Key)
}

extension Never : CodingKey {}

extension Array where Element == LocationPathComponent<Never> {
	public init(_ literals: String...) {
		self = literals.map { .literal($0) }
	}
}

typealias Path = [String]
