// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

/// A top-level fragment representing an HTML document.
public struct Document : Fragment {
	
	/// Creates a DTD.
	public init() {}
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		let document = XMLDocument()
		document.documentContentKind = .xhtml
		graph.produce(document as! G.Artefact, at: location)
	}
	
}
