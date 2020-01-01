// Spin © 2019 Constantino Tsarouhas

import DepthKit
import Vapor

/// A value that encapsulates the information necessary for performing an action.
///
/// Actions work in conjunction with actionable components (cf. `ActionableComponent`). When the server receives an action, the system looks up the actionable component type that is registered for the location, creates an instance of the associated action type, executes it, then uses the action's result to create an instance of the actionable component type.
///
/// If `Result` conforms to `Codable`, the system creates a `304 See Other` redirection response redirecting to the actionable component via a `GET` request. The result is encoded in the URL.
public protocol ActionProtocol : Content {
	
	/// The type of values that can be used to encode an action on a client.
	associatedtype CodingKeys : CodingKey
	
	/// The type of values produced by the action when executed.
	associatedtype Location : LocationProtocol
	
	/// The type of values produced by the action when executed.
	associatedtype Result
	
	/// Executes the action.
	///
	/// Spin invokes this method and uses the result to create the actionable component that can present or otherwise handle the result. If the future value fails to be produced, the actionable component is not created and the error is dealt on the application level.
	func execute(on request: Request, location: Location) -> Future<Result>
	
}

extension ActionProtocol where Result : Codable {
	
	/// Creates a URL encoding given result.
	static func url(for result: Result, location: Location) throws -> URL {
		var urlComponents = NSURLComponents(url: try location.urlRepresentation(), resolvingAgainstBaseURL: false)! as URLComponents
		urlComponents.percentEncodedQuery = try String(bytes: URLEncodedFormEncoder().encode(result), encoding: .utf8)
		return urlComponents.url!
	}
	
}
