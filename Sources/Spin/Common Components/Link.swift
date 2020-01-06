// Spin © 2019 Constantino Tsarouhas

import Foundation

/// A component representing an HTML document.
public struct Link<Contents : Component> : Component {
	
	/// Creates a link referencing given URL and containing given contents.
	public init(to url: URL, @ComponentBuilder contents: @escaping () -> Contents) {
		self.url = url
		self.contents = contents
	}
	
	/// Creates a link referencing given component and containing given contents.
	public init<C : LocatableComponent>(to component: C, @ComponentBuilder contents: @escaping () -> Contents) {
		self.init(to: try! component.location.urlRepresentation(), contents: contents)
	}
	
	/// The URL referenced by the link.
	public let url: URL
	
	/// The link's contents.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Component {
		contents()
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		renderer.openElement(tagName: "a", attributeValuesByName: ["href" : url.absoluteString])
		renderer.addComponent(contents())
		renderer.closeElement()
	}
	
}

extension Link where Contents == Text {
	
	/// Creates a link referencing given URL and containing given text.
	public init(to location: URL, label: String) {
		self.init(to: location) {
			Text(label)
		}
	}
	
	/// Creates a link referencing given component and containing given text.
	public init<C : LocatableComponent>(to component: C, label: String) {
		self.init(to: component) {
			Text(label)
		}
	}
	
}
