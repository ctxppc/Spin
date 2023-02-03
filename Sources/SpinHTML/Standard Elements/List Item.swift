// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct ListItem<Contents : Fragment> : Fragment {
	
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
		graph.produce(XMLElement(name: "li") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension ListItem where Contents == Text {

	/// Creates a list item containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}

}
