// Spin © 2019–2021 Constantino Tsarouhas

/// A container component consisting of two components in succession.
///
/// Groups can be nested to create groups of arbitrary size, e.g., a `Group<Group<A, B>, C>` containing three components `A`, `B`, and `C` in succession.
///
/// As with other container components, groups do not have any intrinsic semantic meaning or behaviour.
public struct Group<First : Component, Second : Component> : Component {
	
	/// Creates a group with given components.
	public init(_ first: First, _ second: Second) {
		self.first = first
		self.second = second
	}
	
	/// Creates a group using given closure.
	public init(@ComponentBuilder _ contents: () -> Self) {
		self = contents()
	}
	
	/// The first component.
	public let first: First
	
	/// The second component.
	public let second: Second
	
	/// A type that allows concatenating a third component to groups of this type.
	///
	/// This convenience syntax allows writing `Group<A, B>.Con<C>` instead of `Group<Group<A, B>, C>`.
	public typealias Con<Third : Component> = Group<Self, Third>
	
	/// Concatenates a third component to this group.
	///
	/// This convenience syntax allows writing `Group(a, b).con(c)` instead of `Group(Group(a, b), c)`.
	public func con<Third : Component>(_ third: Third) -> Self.Con<Third> {
		.init(self, third)
	}
	
	// See protocol.
	public var body: some Component {
		EmptyComponent()
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		renderer.addComponent(first)
		renderer.addComponent(second)
	}
	
}
