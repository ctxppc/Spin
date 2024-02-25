// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct Paragraph<Contents : Fragment> : Fragment {
	
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
		graph.produce(XMLElement(name: "p") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension Paragraph where Contents == Text {

	/// Creates a paragraph containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}

}
