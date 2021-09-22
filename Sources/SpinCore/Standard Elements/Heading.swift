// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A component representing an HTML document.
public struct Heading<Contents : Fragment> : Fragment {
	
	public init(level: Int, @ComponentBuilder contents: @escaping () -> Contents) {
		precondition((1...6).contains(level), "Heading level must be between 1 and 6 (inclusive)")
		self.level = level
		self.contents = contents
	}
	
	/// The heading level.
	public let level: Int
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "h\(level)", contents: contents)
	}
	
}

//extension Heading where Contents == Text {
//
//	/// Creates a heading of given level and containing given text.
//	public init(level: Int, text: String) {
//		self.init(level: level) {
//			Text(text)
//		}
//	}
//
//}
