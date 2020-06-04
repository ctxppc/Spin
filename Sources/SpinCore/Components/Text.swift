// Spin © 2019–2020 Constantino Tsarouhas

/// A component representing a text node.
public struct Text : Component {
	
	/// Creates a text component with given text value.
	public init(_ value: String) {
		self.value = value
	}
	
	/// The text component's text value.
	///
	/// The text value should consist of exactly one line, with no vertical whitespace characters. A text node with more than one line of text might not be indented properly in the string representation.
	public var value: String
	
	// See protocol.
	public var body: some Component {
		EmptyComponent()
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		renderer.addNode(HTMLTextNode(value))
	}
	
}
