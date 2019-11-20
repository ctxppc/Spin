// Spin © 2019 Constantino Tsarouhas

import DepthKit
import Vapor

/// A value that encapsulates the values of a component's dynamic properties such as `@Contextual` and `@Request` properties.
///
/// To add a property to contexts, declare a property in an extension of this type and return `self[keyPath]` in the getter where `keyPath` is the key path of the new property. Spin manages the property's storage.
public struct Context {
	
	/// Creates an empty context.
	internal init() {
		self.contextualValuesByKeyPath = [:]
	}
	
	/// The contextual values by key path.
	private var contextualValuesByKeyPath: [PartialKeyPath<Self> : Any]
	
	/// Accesses the contextual value at a given key path.
	public internal(set) subscript <Value>(keyPath: KeyPath<Context, Value>) -> Value {
		get { (contextualValuesByKeyPath[keyPath as PartialKeyPath] !! "Contextual value not available") as! Value }
		set { contextualValuesByKeyPath[keyPath as PartialKeyPath] = newValue }
	}
	
}
