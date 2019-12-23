// Spin © 2019 Constantino Tsarouhas

import Fluent
import Vapor

/// A dynamic property that evaluates to the result of a database query.
@propertyWrapper
public struct QueryResult<Result> : DynamicProperty {
	
	/// Creates a query result with given query.
	public init(_ query: @escaping Query) {
		self.query = query
		self.hasReadPermission = { _, _ in true }
	}
	
	/// The formula of the query to evaluate.
	private let query: Query
	public typealias Query = (DatabaseConnectable) throws -> Future<Result>
	
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
	public func prepareForRendering(by renderer: Renderer) -> Future<Self> {
		do {
			return try query(renderer.request).map { result in
				guard try self.hasReadPermission(result, renderer.request) else { throw ModelRetrievalError.unauthorised() }
				var copy = self
				copy.storedResult = result
				return copy
			}
		} catch {
			return renderer.request.future(error: error)
		}
	}
	
}

extension QueryResult where Result : Model {
	
	/// Creates a query result that retrieves a model value with specified identifier.
	public init(identifier: Result.ID) {
		self.init {
			Result.find(identifier, on: $0).map { value in
				guard let value = value else { throw ModelRetrievalError.notFound() }
				return value
			}
		}
	}
	
}

extension QueryResult where Result : OptionalType, Result.WrappedType : Model {
	
	/// Creates a query result that retrieves a model value with specified identifier.
	public init(identifier: Result.WrappedType.ID) {
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
	public init(identifier: Result.ID, requiringReadPermission: Bool = true) {
		self.init({
			Result.find(identifier, on: $0).map { value in
				guard let value = value else { throw ModelRetrievalError.notFound() }
				return value
			}
		}, requiringReadPermission: requiringReadPermission)
	}
	
}

extension QueryResult where Result : OptionalType, Result.WrappedType : ControlledModel {
	
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
	public init(identifier: Result.WrappedType.ID, requiringReadPermission: Bool = true) {
		self.init({
			Result.WrappedType.find(identifier, on: $0)
				.map(Result.makeOptionalType)
		}, requiringReadPermission: requiringReadPermission)
	}
	
}
