// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// An XML attribute.
public struct Comment : Fragment {
	
	/// Creates a comment.
	public init(_ text: String) {
		self.text = text
	}
	
	/// The comment's text.
	public let text: String
	
	// See protocol.
	public var body: some Fragment {
		Empty()
	}
	
	// See protocol.
	public static var nodeKind: XMLNode.Kind { .comment }
	
	// See protocol.
	public static func update(_ node: XMLNode, for shadow: Shadow<Self>) async throws {
		node.stringValue = try await shadow.text
	}
	
}
