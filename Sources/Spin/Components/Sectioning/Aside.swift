// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component that groups components that form an aside.
///
/// A typical aside consists of a header (`Header`), body, and footer (`Footer`). Standalone text components in the body are presumed to be paragraphs of the aside.
public struct Aside<Contents : Component> : Component {
	
	/// Creates an aside with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentProvider) {
		self.contents = contents
	}
	
	/// The aside's contents.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
