// Spin © 2019–2020 Constantino Tsarouhas

import Fluent
import Vapor

/// A dynamic property that evaluates to the result of a database query.
@propertyWrapper
public struct QueryResult<Result> /*: DynamicProperty*/ {
	
	/// Creates a query result with given query.
	public init(_ query: @escaping Query) {
		self.query = query
		self.hasReadPermission = { _, _ in true }
	}
	
	/// The formula of the query to evaluate.
	private let query: Query
	public typealias Query = (Database) throws -> EventLoopFuture<Result>
	
	/// A function that determines whether a given result is permitted to be read on a given request.
	private let hasReadPermission: (Result, Request) throws -> Bool
	
	/// The result of the query.
	public var wrappedValue: Result {
		guard let result = storedResult else { preconditionFailure("Accessing query result that hasn't been prepared properly") }
		return result
	}
	
	/// The result of the query, or `nil` if the query result hasn't been prepared.
	private var storedResult: Result?
	
	// See protocol.
	public func prepareForRendering(by renderer: Renderer) -> EventLoopFuture<Self> {
		do {
			return try query(renderer.request.db).flatMapThrowing { result in
				guard try self.hasReadPermission(result, renderer.request) else { throw ModelRetrievalError.unauthorised() }
				var copy = self
				copy.storedResult = result
				return copy
			}
		} catch {
			return renderer.request.eventLoop.makeFailedFuture(error)
		}
	}
	
}

extension QueryResult where Result : Model {
	
	/// Creates a query result that retrieves a model value with specified identifier.
	public init(identifier: Result.IDValue) {
		self.init {
			Result.find(identifier, on: $0).flatMapThrowing { value in
				guard let value = value else { throw ModelRetrievalError.notFound() }
				return value
			}
		}
	}
	
}

extension QueryResult where Result : Vapor.OptionalType, Result.WrappedType : Model {
	
	/// Creates a query result that retrieves a model value with specified identifier.
	public init(identifier: Result.WrappedType.IDValue) {
		self.init {
			Result.WrappedType.find(identifier, on: $0)
				.map(Result.makeOptionalType)
		}
	}
	
}

extension QueryResult where Result : ControlledModel {
	
	/// Creates a query result with given query.
	public init(_ query: @escaping Query, requiringReadPermission: Bool = true) {
		self.query = query
		self.hasReadPermission = { result, request in
			try !requiringReadPermission || result.accessPermission(on: request) >= .read
		}
	}
	
	/// Creates a query result that retrieves a model value with specified identifier.
	public init(identifier: Result.IDValue, requiringReadPermission: Bool = true) {
		self.init({
			Result.find(identifier, on: $0).flatMapThrowing { value in
				guard let value = value else { throw ModelRetrievalError.notFound() }
				return value
			}
		}, requiringReadPermission: requiringReadPermission)
	}
	
}

extension QueryResult where Result : Vapor.OptionalType, Result.WrappedType : ControlledModel {
	
	/// Creates a query result with given query.
	public init(_ query: @escaping Query, requiringReadPermission: Bool = true) {
		self.query = query
		self.hasReadPermission = { result, request in
			guard let result = result.wrapped else { return true }
			guard requiringReadPermission else { return true }
			return try result.accessPermission(on: request) >= .read
		}
	}
	
	/// Creates a query result that retrieves a model value with specified identifier.
	public init(identifier: Result.WrappedType.IDValue, requiringReadPermission: Bool = true) {
		self.init({
			Result.WrappedType.find(identifier, on: $0)
				.map(Result.makeOptionalType)
		}, requiringReadPermission: requiringReadPermission)
	}
	
}
