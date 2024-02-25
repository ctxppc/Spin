// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that groups semantically related components without attaching a more specific meaning to that grouping.
///
/// A typical section consists of a header (`Header`), body, and footer (`Footer`). Standalone text components in the body are presumed to be paragraphs of the section.
///
/// Use more specific sectioning components when possible. For example, group components that belong to a single article in an `Article`.
public struct Section<Contents : Component> : Component {
	
	/// Creates a section with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentProvider) {
		self.contents = contents
	}
	
	/// The section's contents.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
