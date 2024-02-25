// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import DepthKit

/// A container of contextual values.
public struct Context {
	
	/// The contextual values by key path.
	private var valuesByKeyPath: [PartialKeyPath<Self> : Any]
	
	/// Accesses the contextual value at a given key path.
	public subscript <Value>(keyPath: KeyPath<Self, Value>) -> Value {
		get { (valuesByKeyPath[keyPath as PartialKeyPath] !! "Contextual value not available") as! Value }
		set { valuesByKeyPath[keyPath as PartialKeyPath] = newValue }
	}
	
}
