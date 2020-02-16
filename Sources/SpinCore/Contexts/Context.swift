// Spin © 2019–2020 Constantino Tsarouhas

import DepthKit
import Vapor

/// A value that encapsulates the specific state in which a component is rendered.
///
/// The context of a component is set up by its ancestor components and by the system. It is a mechanism by which information can flow from parent component to child components which having to define a property for every possible piece of information that needs to flow downwards.
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
