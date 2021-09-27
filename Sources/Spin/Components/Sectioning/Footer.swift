// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that provides copyright notices, author information, disclaimers, summaries, or other content at the bottom of the nearest enclosing sectioning component (e.g., document, section, article, group, or table).
public struct Footer<Contents : Component> : Component {
	
	/// Creates a footer with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.contents = contents
	}
	
	/// The footer's contents.
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
