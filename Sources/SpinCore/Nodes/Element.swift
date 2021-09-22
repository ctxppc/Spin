// Spin © 2019–2021 Constantino Tsarouhas

import Foundation

/// A value that represents an HTML element.
public struct Element {
	
	/// Creates an element.
	public init(tagName: String, explicitEndTag: Bool = false) {
		self.tagName		= tagName
		self.explicitEndTag	= explicitEndTag
	}
	
	/// The tag name associated with the element.
	public var tagName: String
	
	/// Whether the element always has an explicit end tag.
	public var explicitEndTag: Bool = false
	
}

extension Element : Node {
	public func serialised<Children : Collection>(children: Children, depth: Int) -> String where Children.Element : Node {
		
		TODO.unimplemented
		
//		let usesSelfClosingTag = subnodes.isEmpty && !explicitEndTag
//		let rendersBodyInline = subnodes.contains(where: { $0.isText })
//
//		let startTag: String = {
//
//			var attributes = self.attributes
//			if !classNames.isEmpty {
//				attributes["class"] = classNames.joined(separator: " ")
//			}
//
//			let attributesSegment: String
//			if attributes.isEmpty {
//				attributesSegment = ""
//			} else {
//				let attributeList = attributes.map { key, value in
//					#"\#(key)="\#(value.htmlEscaped())""#
//				}.joined(separator: " ")
//				attributesSegment = " \(attributeList)"
//			}
//
//			return usesSelfClosingTag ? "<\(tagName)\(attributesSegment) />" : "<\(tagName)\(attributesSegment)>"
//
//		}()
//
//		let body: String? = {
//			guard !subnodes.isEmpty else { return nil }
//			return subnodes.map {
//				$0.stringRepresentation(depth: depth + 1, renderingRootInline: rendersBodyInline)
//			}.joined(separator: rendersBodyInline ? "" : "\n")
//		}()
//
//		let endTag = usesSelfClosingTag ? nil : "</\(tagName)>"
//
//		let ind = indentation(depth: depth)
//		let indentedStartTag = ind + startTag
//		let indentedEndTag = endTag.map { ind + $0 }
//
//		switch (renderingRootInline, rendersBodyInline) {
//
//			case (false, false):
//			return [indentedStartTag, body, indentedEndTag].compactMap { $0 }.joined(separator: "\n")
//
//			case (false, true):
//			return [indentedStartTag, body, endTag].compactMap { $0 }.joined()
//
//			case (true, false):
//			return [startTag, body, indentedEndTag].compactMap { $0 }.joined(separator: "\n")
//
//			case (true, true):
//			return [startTag, body, endTag].compactMap { $0 }.joined()
//
//		}
		
	}
}

internal func indentation(depth: Int) -> String {
	.init(repeating: "\t", count: depth)
}

public enum CommonAttribute : String {
	case id
}
