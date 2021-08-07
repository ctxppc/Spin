// Spin © 2019–2021 Constantino Tsarouhas

import Foundation
import SpinCore

/// A form that can be submitted.
public struct Form<Contents : Component> : Component {
	
	/// Creates a form with given URL and containing given contents.
	public init(to url: URL, @ComponentBuilder contents: @escaping () -> Contents) {
		self.url = url
		self.contents = contents
	}
	
	/// Creates a form with given actionable component and containing given contents.
	public init<C : ActionableComponent>(to component: C, @ComponentBuilder contents: @escaping () -> Contents) {
		self.init(to: try! component.location.urlRepresentation(), contents: contents)
	}
	
	/// The URL to the responder.
	public let url: URL
	
	/// The form's contents.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Component {
		contents()
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		renderer.openElement(tagName: "form", attributeValuesByName: ["action" : url.absoluteString, "method": "post"])
		renderer.addComponent(contents())
		renderer.closeElement()
	}
	
}
