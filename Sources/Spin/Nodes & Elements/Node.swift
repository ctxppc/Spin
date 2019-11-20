// Spin © 2019 Constantino Tsarouhas

import Foundation

/// A child node of an element.
public protocol Node {
	
	/// Appends given node at given depth and returns the index path to the newly inserted node.
	///
	/// A `depth` of 0 indicates that the node should be appended to the list of nodes contained in `self`.
	mutating func appendNode(_ node: Node, depth: Int) -> IndexPath
	
	/// Accesses a node.
	///
	/// - Invariant: The accessed node at the empty path is of type `Self`.
	subscript (indexPath: IndexPath) -> Node { get set }
	
	/// Applies given attributes on itself, if applicable.
	mutating func applyAttributes(_ attributes: [String : String])
	
	/// Applies given class names on itself, if applicable.
	mutating func applyClassNames(_ classNames: Set<String>)
	
	/// Returns the node's string representation, suitable for parsing by an HTML parser.
	func stringRepresentation(depth: Int) -> String
	
}
