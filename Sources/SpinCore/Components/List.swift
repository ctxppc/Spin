// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A component consisting of a sequence of connected or related items.
public struct List<Contents : Component> : Component {
	
	/// Creates a list with given contents.
	public init(ordered: Bool = false, @ComponentBuilder _ contents: @escaping ContentProvider) {
		self.ordered = ordered
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the ordering of the items is semantically significant.
	///
	/// List items are always presented in the provided ordering regardless of this property's value, but ordered lists may include numbering.
	public let ordered: Bool
	
	/// The list contents.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Component {
		TODO.unimplemented
	}
	
}
