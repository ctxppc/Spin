// Spin © 2019–2024 Constantino Tsarouhas

import Conifer

/// An XML attribute.
public struct Attribute : Fragment {
	
	/// Creates an attribute.
	public init(namespace: NamespaceIdentifier?, name: AttributeName, value: String) {
		self.namespace = namespace
		self.name = name
		self.value = value
	}
	
	/// The attribute name's namespace, or `nil` if the name is unqualified.
	public let namespace: NamespaceIdentifier?
	
	/// The attribute's name.
	public let name: AttributeName
	
	/// The attribute's value.
	public let value: String
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}
