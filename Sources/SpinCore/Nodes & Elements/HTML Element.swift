// Spin © 2019–2020 Constantino Tsarouhas

import Foundation

/// A value that represents an HTML element.
public struct HTMLElement {
	
	/// Creates an element.
	public init(tagName: String, classNames: Set<String> = [], attributes: [String : String] = [:], explicitEndTag: Bool = false, subnodes: [HTMLNode] = []) {
		self.tagName		= tagName
		self.classNames		= classNames
		self.attributes		= attributes
		self.explicitEndTag	= explicitEndTag
		self.subnodes		= subnodes
	}
	
	/// The tag name associated with the element.
	public var tagName: String
	
	/// The class names associated with the element.
	public var classNames: Set<String> = []
	
	/// The element's attributes, excluding `class`.
	public var attributes: [String : String] = [:]
	
	/// Whether the element always has an explicit end tag.
	public var explicitEndTag: Bool = false
	
	/// The nodes contained in the element's body.
	public var subnodes: [HTMLNode] = []
	
}

extension HTMLElement : HTMLNode {
	
	public mutating func appendNode(_ node: HTMLNode, depth: Int) -> IndexPath {
		switch depth {
			
			case 0:
			subnodes.append(node)
			return [subnodes.indices.last!]
			
			case _:
			let index = subnodes.indices.last!
			let innerPath = subnodes[index].appendNode(node, depth: depth - 1)
			return [index] + innerPath
			
		}
	}
	
	public subscript (indexPath: IndexPath) -> HTMLNode {
		
		get {
			if indexPath.isEmpty {
				return self
			} else {
				return subnodes[indexPath[0]][IndexPath(indexPath.dropFirst())]
			}
		}
		
		set {
			switch indexPath.count {
				case 0:	self = newValue as! Self
				case 1:	subnodes[indexPath[0]] = newValue
				case _:	subnodes[indexPath[0]][IndexPath(indexPath.dropFirst())] = newValue
			}
		}
		
	}
	
	public mutating func applyAttributes(_ attributes: [String : String]) {
		self.attributes.merge(attributes, uniquingKeysWith: { $1 })
	}
	
	public mutating func applyClassNames(_ classNames: Set<String>) {
		self.classNames.formUnion(classNames)
	}
	
	public func stringRepresentation(depth: Int = 0, renderingRootInline: Bool) -> String {
		
		let usesSelfClosingTag = subnodes.isEmpty && !explicitEndTag
		let rendersBodyInline = subnodes.contains(where: { $0.isText })
		
		let startTag: String = {
			
			var attributes = self.attributes
			if !classNames.isEmpty {
				attributes["class"] = classNames.joined(separator: " ")
			}
			
			let attributesSegment: String
			if attributes.isEmpty {
				attributesSegment = ""
			} else {
				let attributeList = attributes.map { key, value in
					#"\#(key)="\#(value.htmlEscaped())""#
				}.joined(separator: " ")
				attributesSegment = " \(attributeList)"
			}
			
			return usesSelfClosingTag ? "<\(tagName)\(attributesSegment) />" : "<\(tagName)\(attributesSegment)>"
			
		}()
		
		let body: String? = {
			guard !subnodes.isEmpty else { return nil }
			return subnodes.map {
				$0.stringRepresentation(depth: depth + 1, renderingRootInline: rendersBodyInline)
			}.joined(separator: rendersBodyInline ? "" : "\n")
		}()
		
		let endTag = usesSelfClosingTag ? nil : "</\(tagName)>"
		
		let ind = indentation(depth: depth)
		let indentedStartTag = ind + startTag
		let indentedEndTag = endTag.map { ind + $0 }
		
		switch (renderingRootInline, rendersBodyInline) {
			
			case (false, false):
			return [indentedStartTag, body, indentedEndTag].compactMap { $0 }.joined(separator: "\n")
			
			case (false, true):
			return [indentedStartTag, body, endTag].compactMap { $0 }.joined()
			
			case (true, false):
			return [startTag, body, indentedEndTag].compactMap { $0 }.joined(separator: "\n")
			
			case (true, true):
			return [startTag, body, endTag].compactMap { $0 }.joined()
			
		}
		
	}
	
	public var isText: Bool { false }
	
}

extension HTMLElement {
	
	/// Assigns an identifier to the element, overwriting any existing identifier.
	public func identified(by identifier: String) -> Self {
		attribute(CommonAttribute.id, value: identifier)
	}
	
	/// Assigns the element to given class.
	public func member<Class : RawRepresentable>(of c: Class) -> Self where Class.RawValue == String {
		var copy = self
		copy.classNames.insert(c.rawValue)
		return copy
	}
	
	/// Assigns the element to given classes.
	public func member(of c: String...) -> Self {
		var copy = self
		copy.classNames.formUnion(c)
		return copy
	}
	
	/// Assigns a value to given attribute, overwriting any previous value.
	public func attribute<Attribute : RawRepresentable, Value : LosslessStringConvertible>(_ attribute: Attribute, value: Value) -> Self where Attribute.RawValue == String {
		var copy = self
		copy.attributes[attribute.rawValue] = value.description
		return copy
	}
	
	/// Assigns a value to given attribute, overwriting any previous value.
	public func attribute(_ attribute: String, value: String) -> Self {
		var copy = self
		copy.attributes[attribute] = value
		return copy
	}
	
}

internal func indentation(depth: Int) -> String {
	.init(repeating: "\t", count: depth)
}

public enum CommonAttribute : String {
	case id
}
