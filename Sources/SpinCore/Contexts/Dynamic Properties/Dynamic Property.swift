// Spin © 2019–2020 Constantino Tsarouhas

/// A property whose value depends on external state.
///
/// A dynamic property's storage is managed by a realiser.
public protocol DynamicProperty {
	
	/// An opaque identifier for the dynamic property.
	///
	/// This property is accessed & managed by realisers. It must not change.
	///
	/// To implement this requirement, create a stored property and default-initialise it with a new identifier, i.e., `identifier = DynamicPropertyIdentifier()`.
	var identifier: DynamicPropertyIdentifier { get }
	
}

/// An opaque identifier for dynamic properties.
///
/// A dynamic property uses its identifier to request its value from the component realiser's storage. It is an implementation detail of dynamic properties and has no uses in Spin clients.
public final class DynamicPropertyIdentifier : Hashable {
	
	/// Creates a new identifier.
	public init() {
		name = nil
	}
	
	/// The identifier, or `nil` if the realiser hasn't prepared the property.
	var name: String?
	
	// See protocol.
	public func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}
	
	// See protocol.
	public static func == (firstIdentifier: DynamicPropertyIdentifier, otherIdentifier: DynamicPropertyIdentifier) -> Bool {
		firstIdentifier.name == otherIdentifier.name
	}
	
}
