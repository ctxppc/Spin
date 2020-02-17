// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

/// A description of an external property.
///
/// The system retrieves and caches the results of an external property.
public protocol ExternalPropertyDescription : Hashable {
	
	/// Retrieves the value.
	func value(context: Context) -> Future<Value>
	associatedtype Value
	
}

/// A type-erased description of an external property.
///
/// This type is an implementation detail of the framework.
public struct AnyExternalPropertyDescription : ExternalPropertyDescription {
	
	init<Description : ExternalPropertyDescription>(_ description: Description) {
		valueGenerator	= { description.value(context: $0).map { $0 } }
		hashable		= .init(description)
	}
	
	// See protocol.
	public func value(context: Context) -> Future<Any> {
		valueGenerator(context)
	}
	
	/// A witness for the `ExternalPropertyDescription` conformance.
	private let valueGenerator: ValueGenerator
	typealias ValueGenerator = (Context) -> Future<Any>
	
	// See protocol.
	public func hash(into hasher: inout Hasher) {
		hashable.hash(into: &hasher)
	}
	
	// See protocol.
	public static func == (description: Self, otherDescription: Self) -> Bool {
		description.hashable == otherDescription.hashable
	}
	
	/// A witness for the `Hashable` conformance.
	private let hashable: AnyHashable
	
}
