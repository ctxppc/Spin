// Spin © 2019–2021 Constantino Tsarouhas

import SpinCore

/// A semantically insignificant division in a document.
public struct Division<Contents : Component> : ElementComponent {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let tagName = "div"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}
