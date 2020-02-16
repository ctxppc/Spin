// Spin © 2019–2020 Constantino Tsarouhas

/// A value that modifies the context of a component.
public protocol Modifier {
	
	/// The type of the modified component.
	associatedtype Modified : Component
	
	/// Returns a copy of `content` with the applicable modifications performed to it.
	///
	/// Spin provides the effective component to be modified by proxy to avoid binding the modifier to a specific component to be modified.
	///
	/// - Parameter content: The component to modify.
	func body(for content: ModifierProxy) -> Modified
	
	/// Returns a modifier that combines this modifier with a newer modifier of the same type, when both modifiers are applied on the same component.
	///
	/// The default implementation returns `newer`, i.e., the older modifier is ignored.
	func combined(with newer: Self) -> Self
	
}

extension Modifier {
	func combined(with newer: Self) -> Self {
		newer
	}
}
