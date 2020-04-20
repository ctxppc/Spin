// Spin © 2019–2020 Constantino Tsarouhas

import DepthKit
import Vapor

/// A renderer converts a component into HTML nodes.
///
/// Rendering happens in two phases. During the *preparation* phase, the renderer traverses the component tree from top to bottom, invoking the `prepareForRendering(by:)` method along the way. During the *assembling* phase, the renderer converts the prepared components into HTML nodes, starting with the deepest levels and working its way backwards to the top. Since component preparation is a potentially asynchronous operation, rendering is also an asynchronous operation.
///
/// A `Renderer` value is responsible for converting a single component to an HTML node. It renders a tree of components by creating derived renderers who render subcomponents. Renderers cannot be created by clients; use the static method `render(_:for:)` to render a component.
public struct Renderer {
	
	/// Renders given component.
	public static func render<C : Component>(_ component: C, for request: Request) -> EventLoopFuture<[Node]> {
		render(component, for: request, context: .init())
	}
	
	/// Renders given component.
	private static func render<C : Component>(_ component: C, for request: Request, context: Context) -> EventLoopFuture<[Node]> {
		let renderer = Renderer(request: request, context: context)
		return component.prepareForRendering(by: renderer).flatMap { component in
			var renderer = renderer
			component.render(into: &renderer)
			return renderer.producedNodes()
		}
	}
	
	/// Creates a blank renderer for given request and with given component context.
	private init(request: Request, context: Context) {
		self.request = request
		self.context = context
	}
	
	/// The request for which the component is rendered.
	public let request: Request
	
	/// The nodes rendering the component.
	public private(set) var nodes: [Node] = []
	
	/// The future completions for all gaps.
	private var futureGapCompletions: [EventLoopFuture<GapCompletion>] = []
	private struct GapCompletion {
		let indexPath: IndexPath
		let nodes: [Node]
	}
	
	/// The depth at which new nodes are added.
	///
	/// When `openingDepth` is zero, all elements are considered closed and any produced nodes are appended directly to the renderer's list of nodes.
	///
	/// - Invariant: `openingDepth` ≥ 0
	private var openingDepth: Int = 0 {
		willSet { precondition(newValue >= 0, "All elements already closed") }
	}
	
	/// Adds a node to the node tree.
	public mutating func addNode(_ node: Node) {
		insertNode(node)
	}
	
	/// Adds an element to the node tree and leaves it open.
	///
	/// The element must be closed by invoking `closeElement()` on the renderer.
	public mutating func openElement(tagName: String, classNames: Set<String> = [], attributeValuesByName: [String : String] = [:], explicitEndTag: Bool = false) {
		insertNode(Element(tagName: tagName, classNames: classNames, attributes: attributeValuesByName, explicitEndTag: explicitEndTag))
		openingDepth += 1
	}
	
	/// Adds the nodes produced by given component to the node tree.
	public mutating func addComponent<C : Component>(_ component: C) {
		let indexPath = insertNode(Gap())
		futureGapCompletions.append(Self.render(component, for: request, context: context).map { nodes in
			GapCompletion(indexPath: indexPath, nodes: nodes)
		})
	}
	
	/// Adds a node to the node tree and returns the index path to the newly inserted node.
	@discardableResult
	private mutating func insertNode(_ node: Node) -> IndexPath {
		switch openingDepth {
			
			case 0:
			nodes.append(node)
			return [nodes.indices.last!]
			
			case _:
			let index = nodes.indices.last!
			let innerPath = nodes[index].appendNode(node, depth: openingDepth - 1)
			return [index] + innerPath
			
		}
	}
	
	/// Closes the deepest open element.
	public mutating func closeElement() {
		openingDepth -= 1
	}
	
	/// Fulfills a gap in the node tree.
	private mutating func materialiseGap(at indexPath: IndexPath, with nodes: [Node]) {
		var indexPath = indexPath
		let index = indexPath.removeFirst()
		self.nodes[index][indexPath] = Gap(nodes: nodes)
	}
	
	/// Additional attribute values to apply on every top-level element produced by the component being rendered, keyed by attribute name.
	internal var additionalAttributes: [String : String] = [:]
	
	/// Additional class names to apply on every top-level element produced by the component being rendered.
	internal var additionalClassNames: Set<String> = []
	
	/// The context for the component being rendered.
	internal var context = Context()
	
	/// Returns the nodes produced by the component being rendered.
	public func producedNodes() -> EventLoopFuture<[Node]> {
		EventLoopFuture.reduce(into: self, futureGapCompletions, on: request.eventLoop) { renderer, gapCompletion in
			renderer.materialiseGap(at: gapCompletion.indexPath, with: gapCompletion.nodes)
		}.map { renderer in
			
			if renderer.additionalAttributes.isEmpty && renderer.additionalClassNames.isEmpty {
				return renderer.nodes
			}
			
			return renderer.nodes.map { node in
				var node = node
				node.applyAttributes(renderer.additionalAttributes)
				node.applyClassNames(renderer.additionalClassNames)
				return node
			}
			
		}
	}
	
}

/// A node for a component that is eventually converted into nodes.
private struct Gap : Node {
	
	/// Creates a gap node with given subnodes.
	init(nodes: [Node] = []) {
		self.nodes = nodes
	}
	
	/// The nodes produced by the component.
	var nodes: [Node]
	
	// See protocol.
	func appendNode(_ node: Node, depth: Int) -> IndexPath {
		fatalError("Cannot insert nodes in a gap node")
	}
	
	// See protocol.
	subscript (indexPath: IndexPath) -> Node {
		
		get {
			assert(indexPath.isEmpty, "Cannot access nodes in a gap node")
			return self
		}
		
		set {
			assert(indexPath.isEmpty, "Cannot replace nodes in a gap node")
			self = newValue as! Self
		}
		
	}
	
	// See protocol.
	mutating func applyAttributes(_ attributes: [String : String]) {
		self.attributes.merge(attributes, uniquingKeysWith: { $1 })
	}
	
	private var attributes: [String : String] = [:]
	
	// See protocol.
	mutating func applyClassNames(_ classNames: Set<String>) {
		self.classNames.formUnion(classNames)
	}
	
	private var classNames: Set<String> = []
	
	// See protocol.
	func stringRepresentation(depth: Int, renderingRootInline: Bool) -> String {
		nodes.map { node in
			var node = node
			node.applyAttributes(attributes)
			node.applyClassNames(classNames)
			return node.stringRepresentation(depth: depth, renderingRootInline: renderingRootInline)
		}.joined(separator: renderingRootInline ? "" : "\n")
	}
	
	// See protocol.
	var isText: Bool {
		nodes.contains(where: { $0 is TextNode })
	}
	
}

public typealias IndexPath = [Int]
