// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

/// A dynamic property that evaluates to a future value.
@propertyWrapper
public struct FutureValue<Value> : DynamicProperty {
	
	/// Creates a future value property.
	public init(producer: @escaping Producer) {
		self.producer = producer
	}
	
	/// The value.
	public var wrappedValue: Value {
		guard let result = storedValue else { preconditionFailure("Accessing future value that hasn't been prepared properly") }
		return result
	}
	
	/// The value, or `nil` if the promise hasn't been fulfilled.
	private var storedValue: Value?
	
	/// A function producing the future value.
	private let producer: Producer
	public typealias Producer = (Request) throws -> Future<Value>
	
	// See protocol.
	public func prepareForRendering(by renderer: Renderer) -> Future<Self> {
		Future.flatMap(on: renderer.request) {
			try self.producer(renderer.request)
		}.map { value in
			var copy = self
			copy.storedValue = value
			return copy
		}
	}
	
}
