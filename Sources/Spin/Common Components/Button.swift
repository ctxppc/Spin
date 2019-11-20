// Spin © 2019 Constantino Tsarouhas

/// An actionable button in a document.
public struct Button<Contents : Component> : ElementComponent {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let tagName = "button"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension Button where Contents == Text {
	
	/// Creates a button containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}
	
}
