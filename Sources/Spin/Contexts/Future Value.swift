// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

/// A dynamic property that evaluates to a future value.
@propertyWrapper
public struct FutureValue<Value> : DynamicProperty {
	
	/// The value.
	public var wrappedValue: Value {
		guard let result = storedValue else { preconditionFailure("Accessing future value that hasn't been prepared properly") }
		return result
	}
	
	/// The value, or `nil` if the promise hasn't been fulfilled.
	private var storedValue: Value?
	
	/// The future containing the value.
	private let future: Future<Value>
	
	// See protocol.
	public func prepareForRendering(by renderer: Renderer) -> Future<Self> {
		future.map { value in
			var copy = self
			copy.storedValue = value
			return copy
		}
	}
	
}
