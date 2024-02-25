// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A group of input elements in a form.
public struct FieldGroup<Contents : Fragment> : Fragment {
	
	public init(enabled: Bool = true, @ComponentBuilder contents: @escaping ContentProvider) {
		self.enabled = enabled
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the group is enabled.
	public let enabled: Bool
	
	/// The button's contents.
	let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}
