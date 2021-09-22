// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A semantically insignificant span in a document.
public struct Span<Contents : Fragment> : Fragment {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "span", contents: contents)
	}
	
}

//extension Span where Contents == Text {
//
//	/// Creates a span containing given text.
//	public init(_ text: String) {
//		self.init {
//			Text(text)
//		}
//	}
//
//}
