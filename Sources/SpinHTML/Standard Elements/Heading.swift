// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct Heading<Contents : Fragment> : Fragment {
	
	public init(level: Int, @ComponentBuilder contents: @escaping ContentProvider) {
		precondition((1...6).contains(level), "Heading level must be between 1 and 6 (inclusive)")
		self.level = level
		self.contents = contents
	}
	
	/// The heading level.
	public let level: Int
	
	/// The button's contents.
	let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}

extension Heading where Contents == Text {

	/// Creates a heading of given level and containing given text.
	public init(_ text: String, level: Int) {
		self.init(level: level) {
			Text(text)
		}
	}

}
