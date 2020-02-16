// Spin © 2019–2020 Constantino Tsarouhas

/// A value that applies a modifier on a component.
struct ModifiedComponent<Content : Component, ModifierType : Modifier> : Component {
	
	/// The component being modified.
	let content: Content
	
	/// The modifier.
	let modifier: Modifier
	
	// See protocol.
	var body: some Component {
		EmptyComponent()
	}
	
}
