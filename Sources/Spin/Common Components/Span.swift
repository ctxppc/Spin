// Spin © 2019–2020 Constantino Tsarouhas

/// A semantically insignificant span in a document.
public struct Span<Contents : Component> : ElementComponent {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let tagName = "span"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension Span where Contents == Text {
	
	/// Creates a span containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}
	
}
