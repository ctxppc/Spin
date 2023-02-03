// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component representing text.
public struct Text : Component {
	
	/// Creates a component with given text.
	public init(_ value: String) {
		self.value = value
	}
	
	/// The text value.
	public let value: String
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		TODO.unimplemented
	}
	
}
