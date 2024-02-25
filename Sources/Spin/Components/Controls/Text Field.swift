// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A control for text input.
public struct TextField : Component {
	
	/// Creates a text field.
	public init(kind: Kind = .shortform, value: Binding<String>) {
		self.kind = kind
		self._value = value
	}
	
	/// The kind of text field.
	public let kind: Kind
	public enum Kind : String, Sendable {
		case shortform = "text"
		case email
		case password
		case search
		case longform
	}
	
	/// The text field's value.
	@Binding
	private var value: String
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
