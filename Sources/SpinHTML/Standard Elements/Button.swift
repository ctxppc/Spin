// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

/// An actionable button in a document.
public struct Button<Contents : Fragment> : Fragment {
	
	/// Creates a button with given contents.
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLElement(name: "button") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}
