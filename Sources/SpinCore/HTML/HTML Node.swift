// Spin © 2019–2020 Constantino Tsarouhas

import Foundation

/// A child node of an element.
public protocol HTMLNode {
	
	/// Appends given node at given depth and returns the index path to the newly inserted node.
	///
	/// A `depth` of 0 indicates that the node should be appended to the list of nodes contained in `self`.
	mutating func appendNode(_ node: HTMLNode, depth: Int) -> IndexPath
	
	/// Accesses a node.
	///
	/// - Invariant: The accessed node at the empty path is of type `Self`.
	subscript (indexPath: IndexPath) -> HTMLNode { get set }
	
	/// Applies given attributes on itself, if applicable.
	mutating func applyAttributes(_ attributes: [String : String])
	
	/// Applies given class names on itself, if applicable.
	mutating func applyClassNames(_ classNames: Set<String>)
	
	/// Returns the node's string representation, suitable for parsing by an HTML parser.
	///
	/// - Parameter depth: The depth of the node in the rendered tree, where 0 indicates a direct descendant of the document node.
	/// - Parameter renderingRootInline: A Boolean value indicating whether the node and its siblings are being rendered on a single line. For nodes that have a rendering over multiple lines, an argument of `true` indicates that the previous sibling's last character (if any) is on the same line as the first character of `self` and the next sibling's first character (if any) is on the same line as the last character of `self`.
	func stringRepresentation(depth: Int, renderingRootInline: Bool) -> String
	
	/// A Boolean value whether this node is a text node or a combination of a text node and other nodes.
	///
	/// This property is not affected by text nodes *contained* in child or descendant nodes.
	var isText: Bool { get }
	
}
