// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A component representing an HTML document.
public struct Paragraph<Contents : Fragment> : Fragment {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "p", contents: contents)
	}
	
}

//extension Paragraph where Contents == Text {
//
//	/// Creates a paragraph containing given text.
//	public init(_ text: String) {
//		self.init {
//			Text(text)
//		}
//	}
//
//}
//
//extension Paragraph where Contents == FormattedText {
//
//	/// Creates a paragraph containing given formatted text.
//	public init(formattedText: FormattedText) {
//		self.init {
//			formattedText
//		}
//	}
//
//}
