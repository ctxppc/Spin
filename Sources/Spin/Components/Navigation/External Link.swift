// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A component that enables the user or reader to view a resource that isn't part of the web application or site.
///
/// For a link to an internal location, use a `Link`.
public struct ExternalLink<Contents : Component> : Component {
	
	/// Creates a link with given contents.
	public init(to url: URL, @ComponentBuilder _ contents: @escaping ContentProvider) {
		self.url = url
		self.contents = contents
	}
	
	/// The location of the linked resource.
	public let url: URL
	
	/// The link's contents.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	/// The browsing context to use for presenting the linked content.
	@Contextual(\.browsingContextForLinkedExternalContent)
	private var browsingContextForLinkedContent: BrowsingContext
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
