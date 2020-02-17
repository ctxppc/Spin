// Spin © 2019–2020 Constantino Tsarouhas

import DepthKit
import Vapor

/// An object that manages a component's context.
///
/// A component's body must be evaluated within the scope of a realiser who manages any contextual and external properties the component might have.
public final class Realiser {
	
	/// The currently active realiser.
	public static var current: Realiser {
		Self.localRealisers.currentValue!.realisers.last !! "No realiser active"
	}
	
	/// The thread-local realisers.
	private static let localRealisers = ThreadSpecificVariable(value: Collection())
	private final class Collection {
		
		/// The realisers, ordered from outermost to innermost.
		var realisers: [Realiser] = []
		
	}
	
	/// Creates a realiser for given component and with given context.
	init<C : Component>(for component: C, context: Context) {
		
		self.context = context
		
		let externalProperties = Mirror(reflecting: component)
			.children
			.compactMap { $0.value as? AnyExternalProperty }
		
		let completions = externalProperties.map { property -> Future<()> in
			let description = property.typeErasedDescription
			return description.value(context: context).map { result in
				self.context.fulfill(description, with: result)
			}
		}
		
		if let eventLoop = completions.first?.eventLoop {
			dependencyCompletion = Future.andAll(completions, eventLoop: eventLoop)
		}
		
	}
	
	/// The component's context.
	private var context: Context
	
	/// A future completion of all external property dependencies, or `nil` if the component doesn't have any dependencies.
	private var dependencyCompletion: Future<()>?
	
}
