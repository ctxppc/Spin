// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component consisting of a sequence of connected or related items.
public struct List<Contents : Component> : Component {
	
	/// Creates a list with given contents.
	public init(ordered: Bool = false, @ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.ordered = ordered
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the ordering of the items is semantically significant.
	///
	/// List items are always presented in the provided ordering regardless of this property's value, but ordered lists may include numbering.
	public let ordered: Bool
	
	/// The list contents.
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
