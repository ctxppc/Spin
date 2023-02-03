// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing a divider between different segments of a document.
public struct Divider : Fragment {
	
	/// Creates a divider.
	public init() {}
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLElement(name: "hr") as! G.Artefact, at: location)
	}
	
}
