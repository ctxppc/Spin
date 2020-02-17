// Spin © 2019–2020 Constantino Tsarouhas

/// A property whose value depends on external state.
///
/// The system ensures a component's external properties are prefetched.
public protocol ExternalProperty {
	
	/// The description of the external property.
	var description: Description { get }
	associatedtype Description : ExternalPropertyDescription
	
	/// The property's value.
	var wrappedValue: Value { get }
	typealias Value = Description.Value
	
}

/// A type-erased external property.
///
/// This type is an implementation detail of the framework.
///
/// # Implementation Details
///
/// This protocol is a generalisation of `ExternalProperty` without `Self` or associated-type requirements to make it possible to retrieve a component's external properties via runtime reflection.
public protocol AnyExternalProperty {
	
	/// The type-erased description of the external property.
	///
	/// This requirement is an implementation detail of the framework and fulfilled by a default implementation in `ExternalProperty`.
	var typeErasedDescription: AnyExternalPropertyDescription { get }
	
}

extension ExternalProperty {
	var typeErasedDescription: AnyExternalPropertyDescription {
		.init(description)
	}
}
