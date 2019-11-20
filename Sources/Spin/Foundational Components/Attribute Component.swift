// Spin © 2019 Constantino Tsarouhas

/// A component specifying an attribute on the outermost elements generated by the attribute component's inner component.
private struct AttributeComponent<InnerComponent : Component> : Component {
	
	/// The name of the specified attribute.
	let attributeName: String
	
	/// The value of the specified attribute.
	let attributeValue: String
	
	/// The component on which the preference is associated.
	let component: InnerComponent
	
	// See protocol.
	var body: some Component {
		component
	}
	
	// See protocol.
	func render(into renderer: inout Renderer) {
		renderer.additionalAttributes[attributeName] = attributeValue
		renderer.addComponent(component)
	}
	
}

extension Component {
	
	/// Assigns `attribute` on all direct descendent elements generated by `self`.
	public func attribute<Attribute : RawRepresentable, Value : LosslessStringConvertible>(_ attribute: Attribute, value: Value) -> some Component
		where Attribute.RawValue == String {
			self.attribute(attribute.rawValue, value: value.description)
	}
	
	/// Assigns `value` to attribute `name` on all direct descendent elements generated by `self`.
	public func attribute<Value : LosslessStringConvertible>(_ name: String, value: Value) -> some Component {
		AttributeComponent(attributeName: name, attributeValue: value.description, component: self)
	}
	
	/// Assigns `value` to attribute `name` on all direct descendent elements generated by `self`.
	public func attribute(_ name: String, value: Bool) -> some Component {
		(value ? AttributeComponent(attributeName: name, attributeValue: name, component: self) : nil) ?? self
	}
	
	/// Assigns an identifier to the element represented by `self`, overwriting any existing identifier.
	public func identified(by identifier: String) -> some Component {
		attribute(CommonAttribute.id, value: identifier)
	}
	
}
