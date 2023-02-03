// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct TableRow<Contents : Fragment> : Fragment {
	
	public init(header: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.header = header
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the row is a header.
	public let header: Bool
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLElement(name: header ? "th" : "tr") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension TableRow where Contents == Text {

	/// Creates a table row containing given text.
	public init(_ text: String, header: Bool = false) {
		self.init(header: header) {
			Text(text)
		}
	}

}
