// Spin © 2019–2021 Constantino Tsarouhas

import Vapor
import NIO

/// An object that can provide a component's context.
public protocol ContextProvider : AnyObject {
	
	/// The context.
	var context: Context { get }
	
}

/// An object that manages a stack of context providers.
public final class ContextProviderStack {
	
	/// The local stack.
	public static var local: ContextProviderStack {
		if let stack = localStorage.currentValue {
			return stack
		} else {
			let stack = Self()
			localStorage.currentValue = stack
			return stack
		}
	}
	
	/// The storage for the local stacks.
	private static let localStorage = ThreadSpecificVariable(value: ContextProviderStack())
	
	/// The current context provider.
	public var current: ContextProvider? {
		providers.last
	}
	
	/// Adds given provider on the stack.
	func push(_ provider: ContextProvider) {
		providers.append(provider)
	}
	
	/// Removes the innermost provider from the stack.
	///
	/// - Requires: The stack is not empty.
	func pop() {
		providers.removeLast()
	}
	
	/// The providers on the stack, ordered from outermost to innermost.
	private var providers: [ContextProvider] = []
	
}
