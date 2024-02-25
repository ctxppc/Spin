// Spin © 2019–2024 Constantino Tsarouhas

/// A tag name for an element.
public struct TagName : Sendable, LosslessStringConvertible {
	
	/// Creates a tag name.
	///
	/// - Returns: `nil` if `name` is not a valid tag name.
	public init?(_ name: String) {
		guard try! Self.pattern.wholeMatch(in: name) != nil else { return nil }
		self.description = name
	}
	
	/// The tag name.
	public let description: String
	
	/// The pattern that tag names conform to.
	public static let pattern = #/(?:a-zA-Z)+/#	// FIXME: Use correct pattern.
	
}
