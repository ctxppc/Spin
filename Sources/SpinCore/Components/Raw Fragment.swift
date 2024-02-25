// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit
import SpinHTML

/// A component consisting of a fragment of an HTML document with no further processing.
public struct RawFragment<Contents : Fragment> : Component {
	
	/// Creates a component consisting of a given fragment.
	public init(@ComponentBuilder _ contents: @escaping ContentProvider) {
		self.contents = contents
	}
	
	/// The component's fragment contents.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
