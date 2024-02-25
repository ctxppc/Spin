// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A semantically insignificant span in a document.
public struct Span<Contents : Fragment> : Fragment {
	
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

extension Span where Contents == Text {

	/// Creates a span containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}

}
