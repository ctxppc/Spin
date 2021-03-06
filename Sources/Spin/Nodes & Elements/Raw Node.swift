// Spin © 2019–2020 Constantino Tsarouhas

import Foundation

/// A value that represents an unprocessed fragment of HTML.
///
/// Spin inserts the contents of a raw node as-is in the document's string representation, without any indentation or escaping beyond what already is in the raw string representation.
public struct RawNode {
	
	/// Creates a raw node with given string representation.
	public init(stringRepresentation: String) {
		self.stringRepresentation = stringRepresentation
	}
	
	/// The node's string representation.
	public var stringRepresentation: String
	
}

extension RawNode : Node {
	
	public func appendNode(_ node: Node, depth: Int) -> IndexPath {
		fatalError("Raw nodes cannot contain subnodes")
	}
	
	public subscript (indexPath: IndexPath) -> Node {
		
		get {
			assert(indexPath.isEmpty, "Raw nodes cannot contain subnodes")
			return self
		}
		
		set {
			assert(indexPath.isEmpty, "Raw nodes cannot contain subnodes")
			self = newValue as! Self
		}
		
	}
	
	public func applyAttributes(_ attributes: [String : String]) {}
	
	public func applyClassNames(_ classNames: Set<String>) {}
	
	public func stringRepresentation(depth: Int, renderingRootInline: Bool) -> String {
		stringRepresentation
	}
	
	public var isText: Bool { false }
	
}
