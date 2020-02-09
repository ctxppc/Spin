// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

/// A property whose value depends on external state.
///
/// A dynamic property's storage is managed by a realiser.
public protocol DynamicProperty {
	
	/// The property's value.
	///
	/// This value may be a placeholder value the first time the property is accessed.
	///
	/// To implement this requirement, create a computed property that invokes `value(for:using:)` on the current realiser (`Realiser.current`), passing `self` and a generation closure as arguments.
	var wrappedValue: Value { get }
	associatedtype Value : DynamicPropertyValue
	
	/// An opaque identifier for the dynamic property.
	///
	/// This property is accessed & managed by realisers. It must not be modified by other entities.
	///
	/// To implement this requirement, create a stored property and default-initialise it with a new identifier.
	var identifier: DynamicPropertyIdentifier { get }
	
}

/// An opaque identifier for dynamic properties.
///
/// A dynamic property uses its identifier to request its value from the component realiser's storage. It is an implementation detail of dynamic properties and has no uses in Spin clients.
public struct DynamicPropertyIdentifier : Hashable {
	
	/// Creates a new identifier.
	public init() {
		identifier = UUID()
	}
	
	/// The identifier.
	private let identifier: UUID
	
}
