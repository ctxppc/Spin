// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A form that can be submitted.
public struct Form<Contents : Fragment> : Fragment {
	
	/// Creates a form with given URL and containing given contents.
	public init(to url: URL, @ComponentBuilder contents: @escaping ContentProvider) {
		self.url = url
		self.contents = contents
	}
	
	/// The URL to the responder.
	public let url: URL
	
	/// The button's contents.
	let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}
