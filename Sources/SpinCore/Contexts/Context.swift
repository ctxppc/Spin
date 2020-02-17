// Spin © 2019–2020 Constantino Tsarouhas

import DepthKit
import Vapor

/// A value that encapsulates the specific state in which a component is rendered.
///
/// The context of a component is set up by its ancestor components and by the system. It is a mechanism by which information can flow from parent component to child components without having to define a property for every possible piece of information that needs to flow downwards. It additionally allows the system to asynchronously pass external information (like query results from a database) to components.
///
/// # `@Contextual` Properties
///
/// In Spin clients, contexts are prominently visible via `@Contextual` properties and the `context(_:_:)` modifier method. A parent component can assign a property on the context using the modifier; a descendant component can then access this value via a contextual property.
///
/// 	struct Document : Component {
///			var body: some Component {
///				WelcomeText()
///					.context(\.firstName, "Jake")
///			}
/// 	}
///
/// 	struct WelcomeText : Component {
///
///			@Contextual(\.firstName)
///			private var name
///
///			var body: some Component {
///				Text("Welcome, \(name)!")
///			}
///
/// 	}
///
/// To declare a contextual property such as `firstName` in the example above, declare a property in an extension of this type and return `self[keyPath]` in the getter where `keyPath` is the key path of the new property. Spin manages the property's storage.
///
///		extension Context {
///			var firstName: String {
///				self[\.firstName]
///			}
///		}
///
/// Prefer contextual properties above ordinary properties when propagation makes sense, like a database connection or the text font.
///
/// # External Properties
///
/// In addition to propagating contextual properties, contexts also encapsulate external properties. These properties contain values that are requested by a component but originate outside of Spin, like data from a file or server, or query results from a database.
///
/// External properties are assigned by the system and propagate through all components.
public struct Context {
	
	/// Creates an empty context.
	internal init() {
		self.contextualValuesByKeyPath = [:]
		self.externalValuesByDescription = [:]
	}
	
	/// Accesses the contextual value at a given key path.
	public internal(set) subscript <Value>(keyPath: KeyPath<Context, Value>) -> Value {
		get { (contextualValuesByKeyPath[keyPath as PartialKeyPath] !! "Contextual value not available") as! Value }
		set { contextualValuesByKeyPath[keyPath as PartialKeyPath] = newValue }
	}
	
	/// The contextual values, keyed by key path.
	private var contextualValuesByKeyPath: [PartialKeyPath<Self> : Any]
	
	/// Accesses the value for a given external property.
	private subscript <Property : ExternalProperty>(property: Property) -> Property.Value {
		get { (externalValuesByDescription[.init(property.description)] !! "External value not available") as! Property.Value }
		set { externalValuesByDescription[.init(property.description)] = newValue }
	}
	
	/// Fulfills given external property description with given external property value.
	mutating func fulfill(_ description: AnyExternalPropertyDescription, with value: Any) {
		externalValuesByDescription[description] = value
	}
	
	/// The external values, keyed by external property description.
	private var externalValuesByDescription: [AnyExternalPropertyDescription : Any]
	
}
