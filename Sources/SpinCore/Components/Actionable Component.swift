// Spin © 2019–2020 Constantino Tsarouhas

/// A locatable component that can receive actions (e.g., from submitted HTML forms) and act upon them.
///
/// An actionable component can be retrieved either with or without an associated action. In the former case, Spin creates an instance of the component using `init(location:action:)`. In the latter case, Spin creates an instance of the component using `init(location:)` (from `LocatableComponent`).
public protocol ActionableComponent : LocatableComponent {
	
	/// The type of actions that components can act upon.
	associatedtype Action : ActionProtocol where Action.Location == Self.Location
	
	/// Creates an instance for presenting a successfully completed action.
	///
	/// - Parameter location: The location of the component.
	/// - Parameter action: The action that completed.
	/// - Parameter error: The result of the action.
	init(location: Location, action: Action, result: Action.Result)
	
	/// Creates an instance for presenting a failed action.
	///
	/// - Parameter location: The location of the component.
	/// - Parameter action: The action that failed.
	/// - Parameter error: The error produced during execution of the action.
	init(location: Location, action: Action, error: Action.Error)
	
}
