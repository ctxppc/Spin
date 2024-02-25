// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// An interactive element that accepts text.
public struct TextField : Fragment {
	
	/// Creates a text field.
	public init(name: String, value: String = "", placeholder: String = "", kind: Kind = .shortform, required: Bool = false, editable: Bool = true) {
		self.name = name
		self.value = value
		self.placeholder = placeholder
		self.kind = kind
		self.required = required
		self.editable = editable
	}
	
	/// The text field's name, sent during submission of its value.
	private let name: String
	
	/// The text field's current value.
	private let value: String
	
	/// The text field's placeholder, presented when it's empty.
	private let placeholder: String
	
	/// The kind of text field.
	private let kind: Kind
	public enum Kind : String, Sendable {
		case shortform = "text"
		case email
		case password
		case search
		case longform
	}
	
	/// A Boolean value indicating whether the text field must contain a value before it can be submitted.
	private let required: Bool
	
	/// A Boolean value indicating whether the text field can be edited by the user.
	private let editable: Bool
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}
