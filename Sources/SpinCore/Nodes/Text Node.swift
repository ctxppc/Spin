// Spin © 2019–2021 Constantino Tsarouhas

import Foundation

/// A text node.
public struct TextNode {
	
	/// Creates a text node with given text value.
	public init(_ value: String) {
		self.value = value
	}
	
	/// The node's text value.
	///
	/// The text value should consist of exactly one line, with no vertical whitespace characters. A text node with more than one line of text might not be properly indented in the serialised form.
	///
	/// The text value is properly escaped in the serialised form.
	public var value: String
	
}

extension TextNode : Node {
	public func serialised<Children : Collection>(children: Children, depth: Int) -> String where Children.Element : Node {
		precondition(children.isEmpty, "Text nodes cannot contain subnodes.")
		return .init(repeating: "\t", count: depth) + value.htmlEscaped()
	}
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
	#"\"# :	"&quot;",
	"'" :	"&#x27;",
	"/" :	"&#x2F;",
]
