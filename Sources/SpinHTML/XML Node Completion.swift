// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

extension Vertex.ArtefactView.Element where Artefact == XMLNode {
	
	/// Returns a XML node representing `self` with all children attached.
	func completedXMLNode() -> XMLNode {
		
		let childNodes = children.map { $0.completedXMLNode() }
		if let containerNode = artefact as? XMLContainerNode {
			containerNode.setChildren(childNodes)
		} else {
			precondition(childNodes.isEmpty, "\(artefact) does not support having child nodes.")
		}
		
		return artefact
		
	}
	
}

private protocol XMLContainerNode {
	func setChildren(_: [XMLNode]?)
}

extension XMLDocument : XMLContainerNode {}
extension XMLDTD : XMLContainerNode {}
extension XMLElement : XMLContainerNode {}
