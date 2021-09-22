// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A semantically insignificant division in a document.
public struct Division<Contents : Fragment> : Fragment {
	
	/// Creates a division with given contents.
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	/// The division's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "div", contents: contents)
	}
	
}
