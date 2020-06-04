// Spin © 2019–2020 Constantino Tsarouhas

import Foundation

/// A text node.
public struct HTMLTextNode {
	
	/// Creates a text node with given text value.
	public init(_ value: String) {
		self.value = value
	}
	
	/// The node's text value.
	///
	/// The text value should consist of exactly one line, with no vertical whitespace characters. A text node with more than one line of text might not be indented properly in the string representation.
	///
	/// The text value is properly escaped in the node's string representation.
	public var value: String
	
}

extension HTMLTextNode : HTMLNode {
	
	public func appendNode(_ node: HTMLNode, depth: Int) -> IndexPath {
		fatalError("Text nodes cannot contain subnodes")
	}
	
	public subscript (indexPath: IndexPath) -> HTMLNode {
		
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
		renderingRootInline ? value.htmlEscaped() : .init(repeating: "\t", count: depth) + value.htmlEscaped()
	}
	
	public var isText: Bool { true }
	
}

extension String {
	
	/// A literal representation of `self` suitable for insertion into an HTML context.
	///
	/// - Complexity: O(*n*) where *n* is the number of characters in `self`.
	func htmlEscaped() -> String {
		map { entitiesByEscapedCharacters[$0] ?? String($0) }.joined()
	}
	
}

private let entitiesByEscapedCharacters: [Character : String] = [
	"<" :	"&lt;",
	">" : 	"&gt;",
	"\"" :	"&quot;",
	"'" :	"&#x27;",
	"/" :	"&#x2F;",
]
