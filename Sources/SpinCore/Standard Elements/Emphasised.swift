// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A component representing an emphasised span of text or other content.
public struct Emphasised<Contents : Fragment> : Fragment {
	
	/// Creates an emphasised span with given contents.
	public init(strong: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.strong = strong
		self.contents = contents
	}
	
	/// A Boolean value indicating whether strong emphasis is applied.
	public var strong: Bool
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: strong ? "strong" : "em", contents: contents)
	}
	
}

//extension Emphasised where Contents == Text {
//
//	/// Creates an emphasised span of text.
//	public init(strong: Bool = false, text: String) {
//		self.init(strong: strong) {
//			Text(text)
//		}
//	}
//
//}
