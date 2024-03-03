// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// An XML namespace declaration.
public struct Namespace : Fragment {
	
	/// Creates a namespace declaration.
	public init(name: Name, prefix: Prefix) {
		self.name = name
		self.prefix = prefix
	}
	
	/// The declared namespace name (URI).
	public let name: Name
	public struct Name : Sendable, LosslessStringConvertible {
		
		/// Creates a name.
		///
		/// - Returns: `nil` if `name` is not a valid namespace name.
		public init?(_ name: String) {
			guard try! Self.pattern.wholeMatch(in: name) != nil else { return nil }
			self.description = name
		}
		
		/// The URI.
		public let description: String
		
		/// The pattern that URIs conform to.
		public static let pattern = #/(?:a-zA-Z)+/#	// FIXME: Use correct pattern.
		
	}

	
	/// The prefix associated with the namespace.
	public let prefix: Prefix
	public struct Prefix : Sendable, LosslessStringConvertible {
		
		/// Creates a namespace prefix.
		///
		/// - Returns: `nil` if `name` is not a valid namespace prefix.
		public init?(_ prefix: String) {
			guard try! Self.pattern.wholeMatch(in: prefix) != nil else { return nil }
			self.description = prefix
		}
		
		/// The prefix.
		public let description: String
		
		/// The pattern that prefices conform to.
		public static let pattern = #/(?:a-zA-Z)+/#	// FIXME: Use correct pattern.
		
	}
	
	// See protocol.
	public var body: some Fragment {
		Empty()
	}
	
	// See protocol.
	public static var nodeKind: XMLNode.Kind { .namespace }
	
	// See protocol.
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) async throws {
		node.name = .init(try await shadow.prefix)
		node.stringValue = .init(try await shadow.name)
	}
	
}
