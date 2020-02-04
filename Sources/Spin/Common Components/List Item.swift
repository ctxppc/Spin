// Spin © 2019–2020 Constantino Tsarouhas

/// A component representing an HTML document.
public struct ListItem<Contents : Component> : ElementComponent {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let tagName = "li"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension ListItem where Contents == Text {
	
	/// Creates a list item containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}
	
}
