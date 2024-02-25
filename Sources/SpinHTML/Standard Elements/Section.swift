// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A section in a document or article.
public struct Section<Contents : Fragment> : Fragment {
	
	public init(@ComponentBuilder contents: @escaping ContentProvider) {
		self.contents = contents
	}
	
	// See protocol.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}
