// Spin © 2019–2024 Constantino Tsarouhas

import Conifer

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
		TODO.unimplemented
	}
	
}
