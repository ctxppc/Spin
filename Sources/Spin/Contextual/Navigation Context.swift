// Spin © 2019–2021 Constantino Tsarouhas

import Foundation

extension Context {
	
	/// A value providing access to a navigation area.
	public var navigation: NavigationContext {
		get { self[\.navigation] }
		set { self[\.navigation] = newValue }
	}
	
}

/// A value providing a component access to a navigation area.
public struct NavigationContext {
	
	/// Replaces the content of the nearest ancestor navigation area with `content`.
	public func navigate<Content : Component>(to content: Content, browsingContext: BrowsingContext = .current) {
		TODO.unimplemented
	}
	
	/// Replaces the content of the navigation area identified by `areaIdentifier` with `content`.
	public func navigate<Content : Component, Identifier : Hashable>(to content: Content, areaIdentifiedBy areaIdentifier: Identifier, browsingContext: BrowsingContext = .current) {
		TODO.unimplemented
	}
	
	/// Presents the resouce at `url`.
	public func navigate(to url: URL, browsingContext: BrowsingContext = .current) {
		TODO.unimplemented
	}
	
}
