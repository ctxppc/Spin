// Spin © 2019 Constantino Tsarouhas

/// A component represented by zero nodes.
public struct EmptyComponent : Component {
	
	/// Creates an empty component.
	public init() {}
	
	// See protocol.
	public var body: EmptyComponent {
		fatalError("The body of an empty component cannot be accessed.")
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		// Empty, of course
	}
	
}
