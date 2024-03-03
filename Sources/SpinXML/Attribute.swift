// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// An XML attribute.
public struct Attribute : Fragment {
	
	/// Creates an attribute.
	public init(namespace: Namespace.Name?, name: Name, value: String) {
		self.namespace = namespace
		self.name = name
		self.value = value
	}
	
	/// The attribute name's namespace, or `nil` if the name is unqualified.
	public let namespace: Namespace.Name?
	
	/// The attribute's name.
	public let name: Name
	public struct Name : Sendable, LosslessStringConvertible {
		
		/// Creates an attribute name.
		///
		/// - Returns: `nil` if `name` is not a valid attribute name.
		public init?(_ name: String) {
			guard try! Self.pattern.wholeMatch(in: name) != nil else { return nil }
			self.description = name
		}
		
		/// The attribute name.
		public let description: String
		
		/// The pattern that attribute names conform to.
		public static let pattern = #/(?:a-zA-Z)+/#	// FIXME: Use correct pattern.
		
	}

	/// The attribute's value.
	public let value: String
	
	// See protocol.
	public var body: some Fragment {
		Empty()
	}
	
	// See protocol.
	public static var nodeKind: XMLNode.Kind { .attribute }
	
	// See protocol.
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) async throws {
		node.name = .init(try await shadow.name)
		node.uri = try await shadow.namespace.map { .init($0) }
		node.stringValue = try await shadow.value
	}
	
}
