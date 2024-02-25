// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A semantically insignificant span in a document.
public struct Span<Contents : Fragment> : Fragment {
	
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
		graph.produce(XMLElement(name: "span") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension Span where Contents == Text {

	/// Creates a span containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}

}
