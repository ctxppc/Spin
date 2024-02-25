// Spin © 2019–2024 Constantino Tsarouhas

/// An identifier that can be used to qualify a tag or attribute name's namespace.
public struct NamespaceIdentifier : Sendable, LosslessStringConvertible {
	
	/// Creates an identifier.
	///
	/// - Returns: `nil` if `identifier` is not a valid identifier.
	public init?(_ identifier: String) {
		guard try! Self.pattern.wholeMatch(in: identifier) != nil else { return nil }
		self.description = identifier
	}
	
	/// The identifier.
	public let description: String
	
	/// The pattern that identifiers conform to.
	public static let pattern = #/(?:a-zA-Z)+/#	// FIXME: Use correct pattern.
	
}
