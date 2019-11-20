// Spin © 2019 Constantino Tsarouhas

import DepthKit
import Vapor

/// A dynamic property whose value is provided by an ancestor component.
///
/// Accessing a contextual value that is not specified by an ancestor is not permitted.
@propertyWrapper
public struct Contextual<Value> {
	
	public init(_ keyPath: KeyPath<Context, Value>) {
		self.keyPath = keyPath
	}
	
	let keyPath: KeyPath<Context, Value>
	
	public var wrappedValue: Value {
		storedValue !! "Contextual property \(keyPath) hasn't been properly prepared"
	}
	
	fileprivate var storedValue: Value?
	
}

extension Contextual : DynamicProperty {
	public func prepareForRendering(by renderer: Renderer) -> Future<Self> {
		var copy = self
		copy.storedValue = renderer.context[keyPath]
		return renderer.request.future(copy)
	}
}
