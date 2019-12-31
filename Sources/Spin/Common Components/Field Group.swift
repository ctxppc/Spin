// Spin © 2019 Constantino Tsarouhas

/// A group of input elements in a form.
public struct FieldGroup<Contents : Component> : ElementComponent {
	
	public init(enabled: Bool = true, @ComponentBuilder contents: @escaping () -> Contents) {
		self.attributes = enabled ? [:] : ["disabled" : "true"];
		self.contents = contents
	}
	
	// See protocol.
	public let tagName = "fieldset"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String]
	
	// See protocol.
	public let contents: () -> Contents
	
}
