// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A group of input elements in a form.
public struct FieldGroup<Contents : Fragment> : Fragment {
	
	public init(enabled: Bool = true, @ComponentBuilder contents: @escaping () -> Contents) {
		self.enabled = enabled
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the group is enabled.
	public let enabled: Bool
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "fieldset", contents: contents)
	}
	
}
