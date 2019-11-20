// Spin © 2019 Constantino Tsarouhas

/// A semantically insignificant division in a document.
public struct Label<Contents : Component> : ElementComponent {
	
	public init(for identifier: String, @ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
		self.attributes = ["for": identifier]
	}
	
	// See protocol.
	public let tagName = "label"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension Label where Contents == Text {
	
	/// Creates a paragraph containing given text.
	public init(for identifier: String, text: String) {
		self.init(for: identifier) {
			Text(text)
		}
	}
	
}
