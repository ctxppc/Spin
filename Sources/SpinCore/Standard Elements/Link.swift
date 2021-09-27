// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A component representing an HTML document.
public struct Link<Contents : Fragment> : Fragment {
	
	/// Creates a link referencing given URL and containing given contents.
	public init(to url: URL, @ComponentBuilder contents: @escaping () -> Contents) {
		self.url = url
		self.contents = contents
	}
	
	/// The URL referenced by the link.
	public let url: URL
	
	/// The link's contents.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(with(XMLElement(name: "a")) {
			$0.setAttributesWith(["href": url.absoluteString])
		} as! G.Artefact, at: location)
		await graph.render(contents(), at: location[0])
	}
	
}

extension Link where Contents == Text {
	
	/// Creates a link referencing given URL and containing given text.
	public init(_ label: String, to location: URL) {
		self.init(to: location) {
			Text(label)
		}
	}
	
}
