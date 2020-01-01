// Spin © 2019 Constantino Tsarouhas

/// A locatable component that can receive actions (e.g., from submitted HTML forms) and act upon them.
///
/// An actionable component can be retrieved either with or without an associated action. In the former case, Spin creates an instance of the component using `init(location:action:)`. In the latter case, Spin creates an instance of the component using `init(location:)` (from `LocatableComponent`).
public protocol ActionableComponent : LocatableComponent {
	
	/// The type of actions that components can act upon.
	associatedtype Action : ActionProtocol where Action.Location == Self.Location
	
	/// Creates an instance of `Self` with a given location and action result.
	///
	/// This initialiser is used instead of `init(location:)` when a component of this type is retrieved after executing an action.
	init(location: Location, result: Action.Result)
	
}
