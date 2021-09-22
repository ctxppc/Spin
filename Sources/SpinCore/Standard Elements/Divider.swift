// Spin © 2019–2021 Constantino Tsarouhas

import Conifer

/// A component representing a divider between different segments of a document.
public struct Divider : Fragment {
	
	/// Creates a divider.
	public init() {}
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "hr") {}
	}
	
}

extension Empty : Fragment {}
