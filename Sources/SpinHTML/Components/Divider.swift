// Spin © 2019–2020 Constantino Tsarouhas

import SpinCore

/// A component representing a divider between different segments of a document.
public struct Divider : ElementComponent {
	
	public init() {}
	
	// See protocol.
	public let tagName = "hr"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents = EmptyComponent.init
	
}
