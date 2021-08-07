// Spin © 2019–2021 Constantino Tsarouhas

import DepthKit
import SpinCore

/// An interactive element that accepts text.
public struct TextField : Component {
	
	/// Creates a text field.
	public init(name: String, value: String = "", placeholder: String = "", kind: Kind = .shortform, required: Bool = false, editable: Bool = true) {
		self.name = name
		self.value = value
		self.placeholder = placeholder
		self.kind = kind
		self.required = required
		self.editable = editable
	}
	
	/// Creates a text field.
	public init<Action : ActionProtocol>(for action: Action.Type = Action.self, key: Action.CodingKeys, value: String = "", placeholder: String = "", kind: Kind = .shortform, required: Bool = false, editable: Bool = true) {
		self.name = key.stringValue
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
	public enum Kind : String {
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
	public var body: some Component {
		EmptyComponent()
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		
		let isLongForm = kind == .longform
		
		var attributes = ["name": name]
		
		!isLongForm --> (attributes["type"] = kind.rawValue)
		
		let value = self.value.trimmingCharacters(in: .whitespacesAndNewlines)
		(!value.isEmpty && !isLongForm) --> (attributes["value"] = value)
		
		let newPlaceholder = placeholder.trimmingCharacters(in: .whitespacesAndNewlines)
		!newPlaceholder.isEmpty --> (attributes["placeholder"] = newPlaceholder)
		
		required --> (attributes["required"] = "true")
		
		!editable --> (attributes["readonly"] = "true")
		
		renderer.addNode(HTMLElement(
			tagName:	isLongForm ? "textarea" : "input",
			attributes:	attributes,
			subnodes:	isLongForm ? [HTMLTextNode(value)] : []
		))
		
	}
	
}
