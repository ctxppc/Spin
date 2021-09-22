// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct Link<Contents : Fragment> : Fragment {
	
	/// Creates a link referencing given URL and containing given contents.
	public init(to url: URL, @ComponentBuilder contents: @escaping () -> Contents) {
		self.url = url
		self.contents = contents
	}
	
	/// The URL referenced by the link.
	public let url: URL
	
	/// The link's contents.
	public let contents: () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		ElementFragment(tagName: "a", contents: contents)
	}
	
}

//extension Link where Contents == Text {
//	
//	/// Creates a link referencing given URL and containing given text.
//	public init(to location: URL, label: String) {
//		self.init(to: location) {
//			Text(label)
//		}
//	}
//	
//	/// Creates a link referencing given component and containing given text.
//	public init<C : LocatableComponent>(to component: C, label: String) {
//		self.init(to: component) {
//			Text(label)
//		}
//	}
//	
//}
