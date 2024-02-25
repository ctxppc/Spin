// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A label for an input element.
public struct Label<Contents : Fragment> : Fragment {
	
	public init(for targetIdentifier: String, @ComponentBuilder contents: @escaping () -> Contents) {
		self.targetIdentifier = targetIdentifier
		self.contents = contents
	}
	
	/// The identifier of the input control for which the label applies.
	public let targetIdentifier: String
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(with(XMLElement(name: "label")) {
			$0.setAttributesWith(["for": targetIdentifier])
		} as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension Label where Contents == Text {
	
	/// Creates a label containing given text.
	public init(_ text: String, for identifier: String) {
		self.init(for: identifier) {
			Text(text)
		}
	}
	
}
