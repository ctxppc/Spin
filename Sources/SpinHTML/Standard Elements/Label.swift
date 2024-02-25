// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A label for an input element.
public struct Label<Contents : Fragment> : Fragment {
	
	public init(for targetIdentifier: String, @ComponentBuilder contents: @escaping ContentProvider) {
		self.targetIdentifier = targetIdentifier
		self.contents = contents
	}
	
	/// The identifier of the input control for which the label applies.
	public let targetIdentifier: String
	
	// See protocol.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}

extension Label where Contents == Text {
	
	/// Creates a label containing given text.
	public init(_ text: String, for identifier: String) {
		self.init(for: identifier) {
			Text(text)
		}
	}
	
}
