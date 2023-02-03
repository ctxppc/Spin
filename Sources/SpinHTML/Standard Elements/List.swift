// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct List<Contents : Fragment> : Fragment {
	
	public init(ordered: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.ordered = ordered
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the list's items have a semantically significant ordering.
	public let ordered: Bool
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLElement(name: ordered ? "ol" : "ul") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}
