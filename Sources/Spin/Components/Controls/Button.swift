// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import DepthKit

/// A control that a user can activate to perform an action.
///
/// Unlike a link, a button may perform an effectful action when the user interacts with it, and as such button interactions are implemented using `POST` requests. When possible, use links instead of buttons to implement purely navigational actions.
public struct Button<Contents : Component> : Component {
	
	/// Creates a button.
	public init(action: @escaping Action, @ComponentBuilder _ contents: @escaping ContentsProvider) {
		self.action = action
		self.contents = contents
	}
	
	/// A function invoked when the user interacts with the button.
	public let action: Action
	public typealias Action = () -> ()
	
	/// The button's contents.
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
