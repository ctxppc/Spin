// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation

extension Vertex.ArtefactView.Element where Artefact == XMLNode {
	
	/// Returns a XML node representing `self` with all children attached.
	func completedXMLNode() -> XMLNode {
		let childNodes = children.map { $0.completedXMLNode() }
		switch artefact {
			
			case let document as XMLDocument:
			document.setChildren(childNodes)
			return document
			
			case let element as XMLElement:
			element.setChildren(childNodes)
			return element
			
			case let other:
			precondition(childNodes.isEmpty, "\(other) contains child nodes. Only element and document nodes support child nodes.")
			return other
			
		}
	}
	
}
