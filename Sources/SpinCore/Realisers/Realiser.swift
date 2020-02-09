// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

/// A value converting a component to an artefact.
public final class Realiser {
	
	/// Returns the realiser active in the current calling context, or `nil` if no realiser is active.
	public static func current() -> Self? {
		TODO.unimplemented
	}
	
	public func value<Property : DynamicProperty>(for property: Property, using generator: @escaping DynamicValueGenerator<Property.Value>) -> Property.Value {
		let identifier = property.identifier
		switch propertyValuesByIdentifier[identifier] {
			
			case nil:
			propertyValuesByIdentifier[identifier] = .ongoing
			propertyValueCompletions.append(generator().map { value in
				self.propertyValuesByIdentifier[identifier] = .value(value)
			}.mapIfError({ error in
				self.propertyValuesByIdentifier[identifier] = .error
				self.propertyGenerationErrors.append(error)
			}))
			return Property.Value.dynamicPropertyPlaceholder
			
			case .value(let value):
			return value as! Property.Value
			
			case .ongoing, .error:
			return Property.Value.dynamicPropertyPlaceholder
			
		}
	}
	
	public typealias DynamicValueGenerator<Value> = () -> Future<Value>
	
	/// The property values by identifier.
	private var propertyValuesByIdentifier: [DynamicPropertyIdentifier : PropertyValue] = [:]
	private enum PropertyValue {
		
		/// The property value has been generated.
		case value(Any)
		
		/// The property value is being generated.
		case ongoing
		
		/// An error has occurred during generation.
		case error
		
	}
	
	/// The future completions of property value generators.
	private var propertyValueCompletions: [Future<()>] = []
	
	/// The errors thrown during property value generation.
	private var propertyGenerationErrors: [Error] = []
	
}
