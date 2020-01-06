// Spin © 2019 Constantino Tsarouhas

/// A label for an input element.
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
	
	/// Creates a label containing given text.
	public init(for identifier: String, text: String) {
		self.init(for: identifier) {
			Text(text)
		}
	}
	
}
