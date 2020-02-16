// Spin © 2019–2020 Constantino Tsarouhas

import SpinCore

/// A component representing an HTML document.
public struct Heading<Contents : Component> : ElementComponent {
	
	public init(level: Int, @ComponentBuilder contents: @escaping () -> Contents) {
		precondition((1...6).contains(level), "Heading level must be between 1 and 6 inclusive")
		self.level = level
		self.contents = contents
	}
	
	/// The heading level.
	public let level: Int
	
	// See protocol.
	public var tagName: String { "h\(level)" }
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension Heading where Contents == Text {
	
	/// Creates a heading of given level and containing given text.
	public init(level: Int, text: String) {
		self.init(level: level) {
			Text(text)
		}
	}
	
}
