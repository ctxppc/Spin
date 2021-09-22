// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A section in a document or article.
public struct Section<Contents : Fragment> : Fragment {
	
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	// See protocol.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "section", contents: contents)
	}
	
}
