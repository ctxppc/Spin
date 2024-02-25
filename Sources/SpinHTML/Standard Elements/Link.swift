// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A component representing an HTML document.
public struct Link<Contents : Fragment> : Fragment {
	
	/// Creates a link referencing given URL and containing given contents.
	public init(to url: URL, @ComponentBuilder contents: @escaping ContentProvider) {
		self.url = url
		self.contents = contents
	}
	
	/// The URL referenced by the link.
	public let url: URL
	
	/// The link's contents.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}

extension Link where Contents == Text {
	
	/// Creates a link referencing given URL and containing given text.
	public init(_ label: String, to location: URL) {
		self.init(to: location) {
			Text(label)
		}
	}
	
}
