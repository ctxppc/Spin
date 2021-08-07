// Spin © 2019–2021 Constantino Tsarouhas

import Vapor

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
		let query = try URLEncodedFormEncoder().encode(status)
		return URL(string: "\(try location.urlRepresentation())?\(query)")!		// FIXME: Implement with URL components instead once the percent-encoding issue has been fixed in Vapor.
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

/// A container for storing an action and its result or error in a redirection routine of a redirecting action.
struct RedirectingActionStatus<Action : RedirectingAction> : Codable {
	
	/// The action that was executed.
	let action: Action
	
	/// The result of the action, or `nil` if the action failed.
	let result: Action.Result?
	
	/// The error of the action, or `nil` if the action succeeded.
	let error: Action.Error?
	
}
