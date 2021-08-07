// Spin © 2019–2021 Constantino Tsarouhas

/// An error during the execution of an action.
public protocol ActionError : Error, Codable {
	
	/// A value indicating an unexpected error.
	///
	/// Unexpected errors are logged by the system and presented as internal server errors.
	static var unexpected: Self { get }
	
}

/// An action error type for use when no errors are expected.
public enum BasicActionError : Int, ActionError {
	
	/// An unexpected error has occurred.
	case unexpectedError = 0
	
	// See protocol.
	public static var unexpected: Self { .unexpectedError }
	
}
