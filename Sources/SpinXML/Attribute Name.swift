// Spin © 2019–2024 Constantino Tsarouhas

/// A name for an attribute.
public struct AttributeName : Sendable, LosslessStringConvertible {
	
	/// Creates an attribute name.
	///
	/// - Returns: `nil` if `name` is not a valid attribute name.
	public init?(_ name: String) {
		guard try! Self.pattern.wholeMatch(in: name) != nil else { return nil }
		self.description = name
	}
	
	/// The attribute name.
	public let description: String
	
	/// The pattern that attribute names conform to.
	public static let pattern = #/(?:a-zA-Z)+/#	// FIXME: Use correct pattern.
	
}
