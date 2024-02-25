// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that provides copyright notices, author information, disclaimers, summaries, or other content at the bottom of the nearest enclosing sectioning component (e.g., document, section, article, group, or table).
public struct Footer<Contents : Component> : Component {
	
	/// Creates a footer with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentProvider) {
		self.contents = contents
	}
	
	/// The footer's contents.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
