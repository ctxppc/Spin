// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an emphasised span of text or other content.
public struct Emphasised<Contents : Fragment> : Fragment {
	
	/// Creates an emphasised span with given contents.
	public init(strong: Bool = false, @ComponentBuilder contents: @escaping ContentProvider) {
		self.strong = strong
		self.contents = contents
	}
	
	/// A Boolean value indicating whether strong emphasis is applied.
	public var strong: Bool
	
	/// The button's contents.
	let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}

extension Emphasised where Contents == Text {

	/// Creates an emphasised span of text.
	public init(_ text: String, strong: Bool = false) {
		self.init(strong: strong) {
			Text(text)
		}
	}

}
