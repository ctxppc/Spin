// Spin © 2019 Constantino Tsarouhas

import Foundation

/// A text node.
public struct TextNode {
	
	/// Creates a text node with given text value.
	public init(_ value: String) {
		self.value = value
	}
	
	/// The node's text value.
	///
	/// The text value should consist of exactly one line, with no vertical whitespace characters. A text node with more than one line of text might not be indented properly in the string representation.
	public var value: String
	
}

extension TextNode : Node {
	
	public func appendNode(_ node: Node, depth: Int) -> IndexPath {
		fatalError("Text nodes cannot contain subnodes")
	}
	
	public subscript (indexPath: IndexPath) -> Node {
		
		get {
			assert(indexPath.isEmpty, "Text nodes cannot contain subnodes")
			return self
		}
		
		set {
			assert(indexPath.isEmpty, "Text nodes cannot contain subnodes")
			self = newValue as! Self
		}
		
	}
	
	public func applyAttributes(_ attributes: [String : String]) {}
	
	public func applyClassNames(_ classNames: Set<String>) {}
	
	public func stringRepresentation(depth: Int, renderingRootInline: Bool) -> String {
		renderingRootInline ? value : .init(repeating: "\t", count: depth) + value
	}
	
	public var isText: Bool { true }
	
}
