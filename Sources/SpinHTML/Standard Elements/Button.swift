// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// An actionable button in a document.
public struct Button<Contents : Fragment> : Fragment {
	
	/// Creates a button with given contents.
	public init(@ComponentBuilder contents: @escaping ContentProvider) {
		self.contents = contents
	}
	
	/// The button's contents.
	let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}
