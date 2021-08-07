// Spin © 2019–2021 Constantino Tsarouhas

import Foundation

public struct HTMLDTD {
	
	/// Creates an HTML DTD.
	public init() {}
	
}

extension HTMLDTD : HTMLNode {
	
	public func appendNode(_ node: HTMLNode, depth: Int) -> IndexPath {
		fatalError("HTML DTDs with subnodes are not supported")
	}
	
	public subscript (indexPath: IndexPath) -> HTMLNode {
		
		get {
			assert(indexPath.isEmpty, "HTML DTDs with subnodes are not supported")
			return self
		}
		
		set {
			assert(indexPath.isEmpty, "HTML DTDs with subnodes are not supported")
			self = newValue as! Self
		}
		
	}
	
	public func applyAttributes(_ attributes: [String : String]) {}
	
	public func applyClassNames(_ classNames: Set<String>) {}
	
	public func stringRepresentation(depth: Int, renderingRootInline: Bool) -> String {
		(renderingRootInline ? "" : indentation(depth: depth)) + "<!DOCTYPE html>"
	}
	
	public var isText: Bool { false }
	
}
