// Spin © 2019–2020 Constantino Tsarouhas

/// A component that presents tabulated data.
public struct Table<Contents : Component> : ElementComponent {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let tagName = "table"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}
