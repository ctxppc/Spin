// Spin © 2019 Constantino Tsarouhas

/// A component that can be requested by visiting a location.
public protocol LocatableComponent : Component {
	
	associatedtype Location : LocationProtocol
	
	/// Creates an instance of `Self` with given location.
	init(location: Location)
	
	/// The component's location.
	var location: Location { get }
	
	/// The title of the component.
	var title: String { get }	// TODO: Replace by preference value when component preferences are implemented.
	
}
