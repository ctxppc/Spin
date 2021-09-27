// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that groups semantically related components without attaching a more specific meaning to that grouping.
///
/// Use more specific sectioning components when possible. For example, group components that belong to a single article in an `Article`.
public struct Section<Contents : Component> : Component {
	
	/// Creates a section with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.contents = contents
	}
	
	/// The section's contents.
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