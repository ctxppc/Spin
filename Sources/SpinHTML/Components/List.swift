// Spin © 2019–2021 Constantino Tsarouhas

import SpinCore

/// A component representing an HTML document.
public struct List<Contents : Component> : ElementComponent {
	
	public init(ordered: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.ordered = ordered
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the list's items have a semantically significant ordering.
	public let ordered: Bool
	
	// See protocol.
	public var tagName: String { ordered ? "ol" : "ul" }
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}
