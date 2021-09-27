// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that enables the user or reader to navigate to a different part of the web application or site.
///
/// For links to external resources, see `ExternalLink`.
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
