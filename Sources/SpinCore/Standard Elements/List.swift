// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A component representing an HTML document.
public struct List<Contents : Fragment> : Fragment {
	
	public init(ordered: Bool = false, @ComponentBuilder contents: @escaping () -> Contents) {
		self.ordered = ordered
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the list's items have a semantically significant ordering.
	public let ordered: Bool
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: ordered ? "ol" : "ul", contents: contents)
	}
	
}
