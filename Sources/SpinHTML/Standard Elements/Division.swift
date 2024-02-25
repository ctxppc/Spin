// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A semantically insignificant division in a document.
public struct Division<Contents : Fragment> : Fragment {
	
	/// Creates a division with given contents.
	public init(@ComponentBuilder contents: @escaping ContentProvider) {
		self.contents = contents
	}
	
	/// The division's contents.
	let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}
