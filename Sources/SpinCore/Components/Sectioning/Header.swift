// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that provides a title, introductory text, or other content at the top of the nearest enclosing sectioning component (e.g., document, section, article, group, or table).
public struct Header<Contents : Component> : Component {
	
	/// Creates a header with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.contents = contents
	}
	
	/// The header's contents.
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
