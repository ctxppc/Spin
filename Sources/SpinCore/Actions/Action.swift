// Spin © 2019–2021 Constantino Tsarouhas

import DepthKit
import Vapor

/// A value that encapsulates the information necessary for performing an action.
///
/// Actions work in conjunction with actionable components (cf. `ActionableComponent`). When the server receives an action, the system looks up the actionable component type that is registered for the location, creates an instance of the associated action type, executes it, then uses the action's result to create an instance of the actionable component type.
public protocol ActionProtocol : Content {
	
	/// The type of values that can be used to encode an action on a client.
	associatedtype CodingKeys : CodingKey
	
	/// The type of values produced by the action when executed.
	associatedtype Location : LocationProtocol
	
	/// The type of errors produced by the action when executed.
	associatedtype Error : ActionError
	
	/// The type of values produced by the action when executed.
	associatedtype Result
	
	/// Executes the action.
	///
	/// Spin invokes this method and uses the result to create the actionable component that can present or otherwise handle the result. Any produced errors that are not of type `Self.Error` are logged and converted to `Self.Error.unexpected`.
	func execute(on request: Request, location: Location) throws -> EventLoopFuture<Result>
	
}
