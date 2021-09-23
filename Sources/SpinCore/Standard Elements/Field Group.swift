// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation

/// A group of input elements in a form.
public struct FieldGroup<Contents : Fragment> : Fragment {
	
	public init(enabled: Bool = true, @ComponentBuilder contents: @escaping () -> Contents) {
		self.enabled = enabled
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the group is enabled.
	public let enabled: Bool
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLElement(name: "fieldset") as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}
