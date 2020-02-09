// Spin © 2019–2020 Constantino Tsarouhas

/// A component specifying a contextual value to be made available to descendants.
private struct ContextProvidingComponent<Value, InnerComponent : Component> : Component {
	
	/// The key path to the contextual value.
	let keyPath: KeyPath<Context, Value>
	
	/// The specified contextual value.
	let value: Value
	
	/// The component on which the contextual value is associated.
	let component: InnerComponent
	
	// See protocol.
	var body: some Component {
		EmptyComponent()
	}
	
	// See protocol.
	func render(into renderer: inout Renderer) {
		renderer.context[keyPath] = value
		renderer.addComponent(component)
	}
	
}

extension Component {
	
	/// Sets the contextual value indicated by given key path to given value.
	public func context<Value>(_ keyPath: KeyPath<Context, Value>, _ value: Value) -> some Component {
		ContextProvidingComponent(keyPath: keyPath, value: value, component: self)
	}
	
}
