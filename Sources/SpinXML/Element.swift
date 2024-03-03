// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// An XML element.
public struct Element<Attributes : Fragment, Children : Fragment> : Fragment {
	
	/// Creates an element.
	public init(
		namespace:						Namespace.Name?,
		name:							Name,
		@ComponentBuilder attributes:	@escaping AttributeProvider,
		@ComponentBuilder children:		@escaping ChildProvider
	) {
		self.namespace = namespace
		self.name = name
		self.attributes = attributes
		self.children = children
	}
	
	/// The tag name's namespace, or `nil` if the tag name is unqualified.
	public let namespace: Namespace.Name?
	
	/// The element's tag name.
	public let name: Name
	public struct Name : Sendable, LosslessStringConvertible {
		
		/// Creates a tag name.
		///
		/// - Returns: `nil` if `name` is not a valid tag name.
		public init?(_ name: String) {
			guard try! Self.pattern.wholeMatch(in: name) != nil else { return nil }
			self.description = name
		}
		
		/// The tag name.
		public let description: String
		
		/// The pattern that tag names conform to.
		public static var pattern: Regex<Substring> { namePattern }
		
	}
	
	/// A function that provides the element's attributes.
	public let attributes: AttributeProvider
	public typealias AttributeProvider = @Sendable () -> Attributes
	
	/// A function that provides the element's children.
	public let children: ChildProvider
	public typealias ChildProvider = @Sendable () -> Children
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
	// See protocol.
	public static var nodeKind: XMLNode.Kind { .element }
	
	// See protocol.
	public static func update(_ node: XMLElement, for shadow: Shadow<Self>) async throws {
		node.name = .init(try await shadow.name)
		node.uri = try await shadow.namespace.map { .init($0) }
	}
	
}

private let namePattern = #/(?:a-zA-Z)+/#	// FIXME: Use correct pattern.
