// Spin © 2019–2020 Constantino Tsarouhas

import SpinCore

/// A component representing an emphasised span of text or other content.
public struct Emphasised<Contents : Component> : ElementComponent {
	
	/// Creates an emphasised span with given contents.
	public init(strong: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.strong = strong
		self.contents = contents
	}
	
	/// A Boolean value indicating whether strong emphasis is applied.
	public var strong: Bool
	
	// See protocol.
	public var tagName: String { strong ? "strong" : "em" }
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension Emphasised where Contents == Text {
	
	/// Creates an emphasised span of text.
	public init(strong: Bool = false, text: String) {
		self.init(strong: strong) {
			Text(text)
		}
	}
	
}
