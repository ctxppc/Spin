// Spin © 2019–2021 Constantino Tsarouhas

import DepthKit
import Vapor

/// An object that manages a component's context.
///
/// A component's body must be evaluated within the scope of a realiser who manages any contextual and external properties the component might have.
public final class Realiser<ComponentType : Component> : ContextProvider {
	
	/// Creates a realiser for given component and with given context.
	init(for component: ComponentType, context: Context) {
		
		self.component = component
		self.context = context
		
		let externalProperties = Mirror(reflecting: component)
			.children
			.compactMap { $0.value as? AnyExternalProperty }
		
		let completions = externalProperties.map { property -> EventLoopFuture<()> in
			let description = property.typeErasedDescription
			return description.value(context: context).map { result in
				self.context.fulfill(description, with: result)
			}
		}
		
		if let eventLoop = completions.first?.eventLoop {
			dependencyCompletion = EventLoopFuture.andAllSucceed(completions, on: eventLoop)
		}
		
	}
	
	/// The component being realised.
	public let component: ComponentType
	
	/// The component's context.
	public private(set) var context: Context
	
	/// A future completion of all external property dependencies, or `nil` if the component doesn't have any dependencies.
	private var dependencyCompletion: EventLoopFuture<()>?
	
	/// Performs a scoped access of the component.
	///
	/// The component's body can be accessed within (and only within) the provided closure.
	///
	/// This method is reentrant over all instances of `Self` including `self`, i.e., `withRealisedComponent(_:on:)` invocations can be nested. When accessing a nested component, it must be scoped using its own realiser.
	public func withRealisedComponent<Result>(_ access: @escaping ScopedAccessor<Result>, on request: Request) -> EventLoopFuture<Result> {
		
		func performScopedAccess() throws -> Result {
			ContextProviderStack.local.push(self)
			defer { ContextProviderStack.local.pop() }
			return try access(component)
		}
		
		if let completion = dependencyCompletion {
			return completion
				.flatMapThrowing(performScopedAccess)
				.hop(to: request.eventLoop)
		} else {
			return EventLoopFuture.map(on: request.eventLoop, performScopedAccess)
		}
		
	}
	
	public typealias ScopedAccessor<Result> = (ComponentType) throws -> Result
	
}
