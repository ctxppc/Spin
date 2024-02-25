// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct Paragraph<Contents : Fragment> : Fragment {
	
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

extension Paragraph where Contents == Text {

	/// Creates a paragraph containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}

}
