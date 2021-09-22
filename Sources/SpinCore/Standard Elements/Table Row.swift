// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A component representing an HTML document.
public struct TableRow<Contents : Fragment> : Fragment {
	
	public init(header: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.header = header
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the row is a header.
	public let header: Bool
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: header ? "th" : "tr", contents: contents)
	}
	
}

//extension TableRow where Contents == Text {
//
//	/// Creates a table row containing given text.
//	public init(header: Bool = false, text: String) {
//		self.init(header: header) {
//			Text(text)
//		}
//	}
//
//}
