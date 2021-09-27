// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import DepthKit
import Foundation

/// A component whose contents can be replaced as the user or reader navigates around the web application or site.
///
/// A navigation area is configured with initial content which can be replaced programmatically (cf. `NavigationContext`) or by the user interacting with a link (cf. `Link`).
public struct NavigationArea<Contents : Component> : Component {
	
	/// Creates a header with given contents.
	public init(@ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.contents = contents
	}
	
	/// The header's contents.
	public let contents: ContentsProvider
	public typealias ContentsProvider = () -> Contents
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		TODO.unimplemented
	}
	
}
