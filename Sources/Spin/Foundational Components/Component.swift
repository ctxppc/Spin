// Spin © 2019 Constantino Tsarouhas

import Vapor

/// A value that represents a number of nodes in an HTML document.
///
/// Components have almost always value semantics and this is a core assumption in Spin.
public protocol Component {
	
	/// The type of the component's contents.
	///
	/// Some component types don't support a body and only have a node representation. These types use an uninhabited type like `EmptyComponent` for their body type.
	associatedtype Body : Component
	
	/// The component's contents.
	var body: Body { get }
	
	/// Prepares the component for rendering.
	///
	/// Components should implement this method by invoking `prepareForRendering(by:)` on every dynamic property they declare. For example,
	///
	///     struct WelcomeBanner : Component {
	///
	///       @Contextual(\.user) var user
	///       @Contextual(\.theme) var theme
	///
	///       func prepareForRendering(by renderer: Renderer) -> Future<Self> {
	///         prepareProperty(\._user, for: renderer)
	///           .flatMap { $0.prepareProperty(\._theme, for: renderer) }
	///       }
	///
	///       var body: some Component { … }
	///
	///     }
	///
	/// Components need not prepare their `body` for rendering. The renderer prepares subcomponents at an appropriate time.
	///
	/// A future version of Spin might remove this requirement.
	///
	/// The default implementation returns `self` unaltered.
	func prepareForRendering(by renderer: Renderer) -> Future<Self>
	
	/// Renders the component to given renderer.
	///
	/// An implementation of this method usually invokes the `add…`, `openElement`, and `closeElement` methods of the renderer as appropriate.
	///
	/// The default implementation renders `body`. This method must be implemented on conforming types that don't support a body.
	///
	/// - Parameter renderer: On input, a renderer with no produced nodes. On output, a renderer with zero or more produced nodes.
	func render(into renderer: inout Renderer)
	
}

extension Component {
	
	public func prepareForRendering(by renderer: Renderer) -> Future<Self> {
		renderer.request.future(self)
	}
	
	public func render(into renderer: inout Renderer) {
		renderer.addComponent(body)
	}
	
}
