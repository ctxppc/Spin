// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import DepthKit
import SpinHTML

/// A component consisting of a fragment of an HTML document with no further processing.
public struct RawFragment<Contents : Fragment> : Component {
	
	/// Creates a component consisting of a given fragment.
	public init(@ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.contents = contents
	}
	
	/// The component's fragment contents.
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
