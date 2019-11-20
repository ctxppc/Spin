// Spin © 2019 Constantino Tsarouhas

/// A component representing an HTML document.
public struct TableRow<Contents : Component> : ElementComponent {
	
	public init(header: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.header = header
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the row is a header.
	public let header: Bool
	
	// See protocol.
	public var tagName: String { header ? "th" : "th" }
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension TableRow where Contents == Text {
	
	/// Creates a table row containing given text.
	public init(header: Bool = false, text: String) {
		self.init(header: header) {
			Text(text)
		}
	}
	
}
