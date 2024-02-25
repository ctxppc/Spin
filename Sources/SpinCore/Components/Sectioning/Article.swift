// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that groups components that form a standalone and atomic unit of content like a blog post, blog comment, or newspaper article.
///
/// A typical article consists of a header (`Header`), body, and footer (`Footer`). Standalone text components in the body are presumed to be paragraphs of the article.
public struct Article<Contents : Component> : Component {
	
	/// Creates an article with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.contents = contents
	}
	
	/// The article's contents.
	public let contents: ContentsProvider
	public typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		TODO.unimplemented
	}
	
}
