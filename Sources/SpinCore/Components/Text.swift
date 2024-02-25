// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component representing text.
public struct Text : Component {
	
	/// Creates a component with given text.
	public init(_ value: String) {
		self.value = value
	}
	
	/// The text value.
	public let value: String
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
