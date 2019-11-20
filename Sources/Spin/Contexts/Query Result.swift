// Spin © 2019 Constantino Tsarouhas

import Vapor

/// A dynamic property that evaluates to the result of a database query.
@propertyWrapper
public struct QueryResult<Formula : QueryFormula> : DynamicProperty {
	
	/// Creates a query result with given query formula.
	public init(_ query: Formula) {
		self.query = query
	}
	
	/// The formula of the query to evaluate.
	public let query: Formula
	
	/// The result of the query.
	public var wrappedValue: Result {
		guard let result = storedResult else { preconditionFailure("Accessing query result that hasn't been prepared properly") }
		return result
	}
	
	/// The result of the query, or `nil` if the query result hasn't been prepared.
	private var storedResult: Result?
	public typealias Result = Formula.Result
	
	// See protocol.
	public func prepareForRendering(by renderer: Renderer) -> Future<Self> {
		query.result(on: renderer.request).map { result in
			var copy = self
			copy.storedResult = result
			return copy
		}
	}
	
}
