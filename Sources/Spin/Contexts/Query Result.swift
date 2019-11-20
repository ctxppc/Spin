// Spin © 2019 Constantino Tsarouhas

import Fluent

/// A dynamic property that evaluates to the result of a database query.
@propertyWrapper
public struct QueryResult<Result> : DynamicProperty {
	
	/// Creates a query result with given query.
	public init(_ query: @escaping Query) {
		self.query = query
	}
	
	/// The formula of the query to evaluate.
	private let query: Query
	public typealias Query = (DatabaseConnectable) -> Future<Result>
	
	/// The result of the query.
	public var wrappedValue: Result {
		guard let result = storedResult else { preconditionFailure("Accessing query result that hasn't been prepared properly") }
		return result
	}
	
	/// The result of the query, or `nil` if the query result hasn't been prepared.
	private var storedResult: Result?
	
	// See protocol.
	public func prepareForRendering(by renderer: Renderer) -> Future<Self> {
		query(renderer.request).map { result in
			var copy = self
			copy.storedResult = result
			return copy
		}
	}
	
}
