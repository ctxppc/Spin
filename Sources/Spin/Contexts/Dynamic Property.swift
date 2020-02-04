// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

/// A property whose value depends on external state.
///
/// A renderer ensures the property is properly prepared before it's accessed.
public protocol DynamicProperty {
	
	/// Prepares the property for rendering.
	func prepareForRendering(by renderer: Renderer) -> Future<Self>
	
}

extension Component {
	
	/// Returns a copy of `self` where the dynamic property at `keyPath` is prepared for rendering by `renderer`.
	public func prepareProperty<Property : DynamicProperty>(_ keyPath: WritableKeyPath<Self, Property>, for renderer: Renderer) -> Future<Self> {
		self[keyPath: keyPath].prepareForRendering(by: renderer).map { property in
			var copy = self
			copy[keyPath: keyPath] = property
			return copy
		}
	}
	
}
