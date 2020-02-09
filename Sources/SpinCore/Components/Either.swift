// Spin © 2019–2020 Constantino Tsarouhas

/// A component that presents one of two components.
public enum Either<First : Component, Second : Component> : Component {
	
	/// The first component is presented.
	case first(First)
	
	/// The second component is presented.
	case second(Second)
	
	// See protocol.
	public var body: some Component {
		EmptyComponent()
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		switch self {
			case .first(let c):		renderer.addComponent(c)
			case .second(let c):	renderer.addComponent(c)
		}
	}
	
}

public func ??<First, Second>(first: First?, second: Second) -> Either<First, Second> {
	first.map { .first($0) } ?? .second(second)
}
