// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A component whose contents can be replaced as the user or reader navigates around the web application or site.
///
/// A navigation area is configured with initial content which can be replaced programmatically (cf. `NavigationContext`) or by the user interacting with a link (cf. `Link`).
public struct NavigationArea<Contents : Component> : Component {
	
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
