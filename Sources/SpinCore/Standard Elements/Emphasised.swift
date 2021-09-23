// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an emphasised span of text or other content.
public struct Emphasised<Contents : Fragment> : Fragment {
	
	/// Creates an emphasised span with given contents.
	public init(strong: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.strong = strong
		self.contents = contents
	}
	
	/// A Boolean value indicating whether strong emphasis is applied.
	public var strong: Bool
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLElement(name: strong ? "strong" : "em") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension Emphasised where Contents == Text {

	/// Creates an emphasised span of text.
	public init(_ text: String, strong: Bool = false) {
		self.init(strong: strong) {
			Text(text)
		}
	}

}
