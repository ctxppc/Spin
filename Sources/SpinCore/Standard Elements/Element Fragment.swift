// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

struct ElementFragment<Contents : Fragment> : Fragment {
	
	/// Creates a fragment representing a single element.
	init(tagName: String, @ComponentBuilder contents: @escaping ContentsProvider) {
		self.tagName = tagName
		self.contents = contents
	}
	
	/// The element's tag name.
	let tagName: String
	
	/// The element's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	var body: some Fragment {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	func render<G : ShadowGraphProtocol>(in graph: inout G, at location: ShadowGraphLocation) async where G.Artefact == Node {
		graph.produce(Element(tagName: tagName), at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension Never : Fragment {}
