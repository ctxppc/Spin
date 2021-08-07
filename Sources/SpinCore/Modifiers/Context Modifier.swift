// Spin © 2019–2021 Constantino Tsarouhas

struct ContextModifier : Modifier {
	
	func body(for content: ModifierProxy) -> some Component {
		EmptyComponent()	// TODO
	}
	
	func combined(with newer: Self) -> Self {
		TODO.unimplemented
	}
	
}
