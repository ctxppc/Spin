// Spin © 2019–2021 Constantino Tsarouhas

/// A component that represents a single element whose contents are determined by a function.
public protocol ElementComponent : Component {
	
	/// The tag name of the element represented by `self`.
	var tagName: String { get }
	
	/// The class names associated with the element represented by `self`.
	var classNames: Set<String> { get set }
	
	/// The attributes, excluding `class`, of the element represented by `self`.
	var attributes: [String : String] { get set }
	
	/// The type of components contained in elements represented by instances of `Self`.
	associatedtype Contents : Component
	
	/// A function that evaluates to the contents of the element represented by `self`.
	var contents: () -> Contents { get }
	
}

extension ElementComponent {
	
	public var body: some Component {
		contents().body
	}
	
	public func render(into renderer: inout Renderer) {
		renderer.openElement(tagName: tagName, classNames: classNames, attributeValuesByName: attributes)
		renderer.addComponent(contents())
		renderer.closeElement()
	}
	
}
