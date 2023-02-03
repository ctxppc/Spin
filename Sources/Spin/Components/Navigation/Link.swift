// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that enables the user or reader to navigate to a different part of the web application or site.
///
/// Unlike a button, a link may not perform an effectful action when a user or reader interacts with it, and as such link interactions are implemented using `GET` requests. Link interactions do not preclude *stateful* actions, however, since any `onAppear` event handlers on the linked content will still run and may affect the application's state. (Note that `onAppear` requires that tasks be *safe* in the REST sense.)
///
/// For a link to an external resource, use an `ExternalLink`.
public struct Link<LinkedContent : Component, Contents : Component> : Component {
	
	/// Creates a link.
	public init(to linkedContent: LinkedContent, @ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.linkedContent = linkedContent
		self.contents = contents
	}
	
	/// The linked content.
	public let linkedContent: LinkedContent
	
	/// The link's contents.
	public let contents: ContentsProvider
	public typealias ContentsProvider = () -> Contents
	
	/// The browsing context to use for presenting the linked content.
	@Contextual(\.browsingContextForLinkedInternalContent)
	private var browsingContextForLinkedContent: BrowsingContext
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		TODO.unimplemented
	}
	
}
