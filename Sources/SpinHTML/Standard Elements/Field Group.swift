// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
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
		graph.produce(with(XMLElement(name: "fieldset")) {
			$0.setAttributesWith(enabled ? [:] : ["disabled": "disabled"])
		} as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}
