// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that provides a title, introductory text, or other content at the top of the nearest enclosing sectioning component (e.g., document, section, article, group, or table).
public struct Header<Contents : Component> : Component {
	
	/// Creates a header with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentProvider) {
		self.contents = contents
	}
	
	/// The header's contents.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
