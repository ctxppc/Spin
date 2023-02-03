// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct NavigationArea<Contents : Fragment> : Fragment {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLElement(name: "nav") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}
