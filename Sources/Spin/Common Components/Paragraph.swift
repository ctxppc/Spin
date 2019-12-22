// Spin © 2019 Constantino Tsarouhas

/// A component representing an HTML document.
public struct Paragraph<Contents : Component> : ElementComponent {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let tagName = "p"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension Paragraph where Contents == Text {
	
	/// Creates a paragraph containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}
	
}

extension Paragraph where Contents == FormattedText {
	
	/// Creates a paragraph containing given formatted text.
	public init(formattedText: FormattedText) {
		self.init {
			formattedText
		}
	}
	
}
