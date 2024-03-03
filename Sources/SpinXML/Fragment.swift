// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A part of an XML document.
public protocol Fragment : Conifer.Component where Body : Component {
	
	/// The kind of XML nodes representing instances of `Self`.
	static var nodeKind: XMLNode.Kind { get }
	
	/// The class of XML nodes representing instances of `Self`.
	associatedtype Node : XMLNode
	
	/// Updates given XML node so that it represents `self`.
	static func update(_ node: Node, for shadow: Shadow<Self>) async throws
	
}

extension Never : Fragment {
	public static var nodeKind: XMLNode.Kind { fatalError() }
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) { fatalError() }
}

extension Empty : Fragment {
	public static var nodeKind: XMLNode.Kind { fatalError() }
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) { fatalError() }
}

extension Optional : Fragment where Wrapped : Fragment {
	public static var nodeKind: XMLNode.Kind { fatalError() }
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) { fatalError() }
}

extension Either : Fragment where First : Component, Second : Fragment {
	public static var nodeKind: XMLNode.Kind { fatalError() }
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) { fatalError() }
}

extension Group : Fragment where repeat each Child : Fragment {
	public static var nodeKind: XMLNode.Kind { fatalError() }
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) { fatalError() }
}

extension ForEach : Fragment where Content : Fragment {
	public static var nodeKind: XMLNode.Kind { fatalError() }
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) { fatalError() }
}
