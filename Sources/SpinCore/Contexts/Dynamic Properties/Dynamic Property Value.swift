// Spin © 2019–2020 Constantino Tsarouhas

/// A value that can be used in a dynamic property.
public protocol DynamicPropertyValue {
	
	/// An arbitrary instance of this type that can act as a placeholder value.
	///
	/// The dynamic property may evaluate to this value when the property is accessed the first time in a body during a document realisation routine. When the realisation system finishes evaluating the effective value, the body property is evaluated again so that it can access the effective value.
	///
	/// A dynamic property also evaluates to this value when it's accessed outside a realisation routine or when an error occurs. Dynamic properties do not have a well-specified value outside the context of a realisation.
	static var dynamicPropertyPlaceholder: Self { get }
	
}

extension Bool : DynamicPropertyValue {
	public static var dynamicPropertyPlaceholder: Self { false }
}

extension Int : DynamicPropertyValue {
	public static var dynamicPropertyPlaceholder: Self { 0 }
}

extension Double : DynamicPropertyValue {
	public static var dynamicPropertyPlaceholder: Self { 0 }
}

extension String : DynamicPropertyValue {
	public static var dynamicPropertyPlaceholder: Self { "" }
}

extension Optional : DynamicPropertyValue {
	public static var dynamicPropertyPlaceholder: Self { nil }
}

extension Array : DynamicPropertyValue {
	public static var dynamicPropertyPlaceholder: Self { [] }
}

extension Dictionary : DynamicPropertyValue {
	public static var dynamicPropertyPlaceholder: Self { [:] }
}
