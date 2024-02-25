// Spin © 2019–2024 Constantino Tsarouhas

import Conifer

/// An XML element.
public struct Element<Attributes : Fragment, Children : Fragment> : Fragment {
	
	/// Creates an element.
	public init(
		namespace:						NamespaceIdentifier?,
		name:							TagName,
		@ComponentBuilder attributes:	@escaping AttributeProvider,
		@ComponentBuilder children:		@escaping ChildProvider
	) {
		self.namespace = namespace
		self.name = name
		self.attributes = attributes
		self.children = children
	}
	
	/// The tag name's namespace, or `nil` if the tag name is unqualified.
	public let namespace: NamespaceIdentifier?
	
	/// The element's tag name.
	public let name: TagName
	
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
	
}
