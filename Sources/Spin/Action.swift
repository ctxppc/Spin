// Spin © 2019 Constantino Tsarouhas

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
	func execute(on request: Request, location: Location) -> Future<Result>
	
}

/// An action whose result is presented after a redirection.
///
/// Instead of rendering the actionable component in the response of the `POST` request, the system creates a `304 See Other` redirection response redirecting to the actionable component via a `GET` request. The result is encoded in the URL.
public protocol RedirectingAction : ActionProtocol where Result : Codable {
	
	/// Returns a location for presenting the result.
	///
	/// The result is encoded separately in the URL.
	///
	/// The default implementation returns `originalLocation`, i.e., the action redirects to the same location.
	func location(for result: Result, originalLocation: Location) -> Location
	
	/// Returns a location for presenting the error.
	///
	/// The error is encoded separately in the URL.
	///
	/// The default implementation returns `originalLocation`, i.e., the action redirects to the same location.
	func location(for error: Error, originalLocation: Location) -> Location
	
}

extension RedirectingAction {
	
	/// Creates a URL encoding given result.
	static func url(for status: RedirectingActionStatus<Self>, location: Location) throws -> URL {
		var urlComponents = NSURLComponents(url: try location.urlRepresentation(), resolvingAgainstBaseURL: false)! as URLComponents
		urlComponents.percentEncodedQuery = try String(bytes: URLEncodedFormEncoder().encode(status), encoding: .utf8)
		return urlComponents.url!
	}
	
	// See protocol.
	func location(for result: Result, originalLocation: Location) -> Location {
		originalLocation
	}
	
	// See protocol.
	func location(for error: Error, originalLocation: Location) -> Location {
		originalLocation
	}
	
}

/// An error during the execution of an action.
public protocol ActionError : Error, Codable {
	
	/// A value indicating an unexpected error.
	///
	/// Unexpected errors are logged by the system and presented as internal server errors.
	static var unexpected: Self { get }
	
}

/// A container for storing an action and its result or error in a redirection routine of a redirecting action.
struct RedirectingActionStatus<Action : RedirectingAction> : Codable {
	
	/// The action that was executed.
	let action: Action
	
	/// The result of the action, or `nil` if the action failed.
	let result: Action.Result?
	
	/// The error of the action, or `nil` if the action succeeded.
	let error: Action.Error?
	
}
