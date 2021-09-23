// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct Heading<Contents : Fragment> : Fragment {
	
	public init(level: Int, @ComponentBuilder contents: @escaping () -> Contents) {
		precondition((1...6).contains(level), "Heading level must be between 1 and 6 (inclusive)")
		self.level = level
		self.contents = contents
	}
	
	/// The heading level.
	public let level: Int
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLElement(name: "h\(level)") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension Heading where Contents == Text {

	/// Creates a heading of given level and containing given text.
	public init(_ text: String, level: Int) {
		self.init(level: level) {
			Text(text)
		}
	}

}
