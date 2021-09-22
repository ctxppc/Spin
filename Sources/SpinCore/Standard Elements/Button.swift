// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// An actionable button in a document.
public struct Button<Contents : Fragment> : Fragment {
	
	/// Creates a button with given contents.
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "button", contents: contents)
	}
	
}
