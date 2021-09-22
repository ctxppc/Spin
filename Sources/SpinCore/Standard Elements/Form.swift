// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation

/// A form that can be submitted.
public struct Form<Contents : Fragment> : Fragment {
	
	/// Creates a form with given URL and containing given contents.
	public init(to url: URL, @ComponentBuilder contents: @escaping () -> Contents) {
		self.url = url
		self.contents = contents
	}
	
	/// The URL to the responder.
	public let url: URL
	
	/// The button's contents.
	let contents: ContentsProvider
	typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "form", contents: contents)
	}
	
}
