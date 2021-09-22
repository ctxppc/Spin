// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A label for an input element.
public struct Label<Contents : Fragment> : Fragment {
	
	public init(for targetIdentifier: String, @ComponentBuilder contents: @escaping () -> Contents) {
		self.targetIdentifier = targetIdentifier
		self.contents = contents
	}
	
	// See protocol.
	public let targetIdentifier: String
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "label", contents: contents)
	}
	
}

//extension Label where Contents == Text {
//	
//	/// Creates a label containing given text.
//	public init(for identifier: String, text: String) {
//		self.init(for: identifier) {
//			Text(text)
//		}
//	}
//	
//}
