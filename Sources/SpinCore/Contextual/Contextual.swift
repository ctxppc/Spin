// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A value providing access to a property in a component's context.
@propertyWrapper
public struct Contextual<Value> {
	
	/// Creates a value providing access to a property in a component's context.
	public init(_ keyPath: KeyPath<Context, Value>) {
		self.keyPath = keyPath
		TODO.unimplemented
	}
	
	/// A key path from a context to the contextual value.
	public let keyPath: KeyPath<Context, Value>
	
	/// The contextual value.
	public private(set) var wrappedValue: Value
	
}
