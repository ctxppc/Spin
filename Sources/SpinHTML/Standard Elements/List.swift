// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct List<Contents : Fragment> : Fragment {
	
	public init(ordered: Bool = false, @ComponentBuilder contents: @escaping ContentProvider) {
		self.ordered = ordered
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the list's items have a semantically significant ordering.
	public let ordered: Bool
	
	// See protocol.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}
