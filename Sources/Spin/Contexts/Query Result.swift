// Spin © 2019 Constantino Tsarouhas

import Fluent

/// A dynamic property that evaluates to the result of a database query.
@propertyWrapper
public struct QueryResult<Model : Fluent.Model, TransformedResult, EvaluatedResult> : DynamicProperty {
	
	/// Creates a query result with given query.
	public init(_ query: EvaluatableQuery<Model, TransformedResult, EvaluatedResult>) {
		self.query = query
	}
	
	/// The query to evaluate.
	public let query: EvaluatableQuery<Model, TransformedResult, EvaluatedResult>
	
	/// The result of the query.
	public var wrappedValue: EvaluatedResult {
		guard let result = storedResult else { preconditionFailure("Accessing query result that hasn't been prepared properly") }
		return result
	}
	
	/// The result of the query, or `nil` if the query result hasn't been prepared.
	private var storedResult: EvaluatedResult?
	
	// See protocol.
	public func prepareForRendering(by renderer: Renderer) -> Future<Self> {
		query.result(on: renderer.request).map { result in
			var copy = self
			copy.storedResult = result
			return copy
		}
	}
	
}

//extension DatabaseQueryResult where EvaluatedResult : OptionalType, EvaluatedResult.WrappedType == TransformedResult {
//
//	/// Creates a query result that evaluates to the first result of a query transformed by a given function.
//	///
//	/// - Parameter modelType: The model type over which the query begins.
//	/// - Parameter transformation: A function that takes a query over all `Model`s and provides a query over the desired `TransformedResult`s.
//	public init(startingFrom modelType: Model.Type, firstOf transformation: @escaping Transformation) {
//		self.transformation = transformation
//		self.evaluation = { query in
//			query.first().map(EvaluatedResult.makeOptionalType)
//		}
//	}
//
//}
//
//extension DatabaseQueryResult where Model == TransformedResult, EvaluatedResult : OptionalType, EvaluatedResult.WrappedType == TransformedResult {
//
//	/// Creates a query result that evaluates to the smallest `Model` by some ordering given by a key path.
//	///
//	/// # Example Usage
//	///
//	///     @FetchedResult(smallest: \.price)
//	///     private var cheapestProduct: Product?
//	///
//	/// - Parameter keyPath: The key path from the `Model`s to some value to order the results by.
//	public init<T>(smallest keyPath: KeyPath<Model, T>) {
//		self.init(startingFrom: Model.self, firstOf: { $0.sort(keyPath, Model.Database.querySortDirectionAscending) })
//	}
//
//	/// Creates a query result that evaluates to the largest `Model` by some ordering given by a key path.
//	///
//	/// # Example Usage
//	///
//	///     @FetchedResult(greatest: \.score)
//	///     private var bestPlayer: Player?
//	///
//	/// - Parameter keyPath: The key path from the `Model`s to some value to order the results by.
//	public init<T>(greatest keyPath: KeyPath<Model, T>) {
//		self.init(startingFrom: Model.self, firstOf: { $0.sort(keyPath, Model.Database.querySortDirectionDescending) })
//	}
//
//}
//
//extension DatabaseQueryResult where EvaluatedResult : RangeReplaceableCollection, EvaluatedResult.Element == TransformedResult {
//
//	/// Creates a query result that evaluates to results of a query transformed by a given function.
//	///
//	/// - Parameter modelType: The model type over which the query begins.
//	/// - Parameter transformation: A function that takes a query over all `Model`s and provides a query over the desired `TransformedResult`s.
//	public init(startingFrom type: Model.Type, allOf transformation: @escaping Transformation) {
//		self.transformation = transformation
//		self.evaluation = { query in
//			query.all().map { results in
//				if EvaluatedResult.self == Array<TransformedResult>.self {	// avoid copying arrays
//					return results as! EvaluatedResult
//				} else {
//					return EvaluatedResult(results)
//				}
//			}
//		}
//	}
//
//}
//
//extension DatabaseQueryResult where Model == TransformedResult, EvaluatedResult : RangeReplaceableCollection, EvaluatedResult.Element == TransformedResult {
//
//	/// Creates a query result that evaluates to all `Model`s by some ordering given by a key path.
//	///
//	/// # Example Usage
//	///
//	///     @FetchedResult(orderedBy: \.name)
//	///     private var users: [User]
//	///
//	/// - Parameter keyPath: The key path from the `Model`s to some value to order the results by.
//	/// - Parameter direction: The direction of the ordering. The default value is ascending, i.e., smallest to greatest.
//	public init<T>(orderedBy keyPath: KeyPath<Model, T>, _ direction: Model.Database.QuerySortDirection = Model.Database.querySortDirectionAscending) {
//		self.init(startingFrom: Model.self, allOf: { $0.sort(keyPath, direction) })
//	}
//
//}

/// A query that can be evaluated on a database connection.
public struct EvaluatableQuery<Model : Fluent.Model, TransformedResult, EvaluatedResult> {
	
	/// A function that takes a query over all `Model`s and provides a query over the desired `TransformedResult`s.
	private let transformation: Transformation
	public typealias Transformation = (QueryBuilder<Model.Database, Model>) -> QueryBuilder<Model.Database, TransformedResult>
	
	/// A function that takes a query over the desired `TransformedResult`s and returns a future `EvaluatedResult`.
	private let evaluation: Evaluation
	private typealias Evaluation = (QueryBuilder<Model.Database, TransformedResult>) -> Future<EvaluatedResult>
	
	/// Evaluates the query on given connection.
	public func result(on connection: DatabaseConnectable) -> Future<EvaluatedResult> {
		(transformation •> evaluation)(Model.query(on: connection))
	}
	
}

extension EvaluatableQuery where EvaluatedResult : OptionalType, EvaluatedResult.WrappedType == TransformedResult {
	
	/// Creates a query that evaluates to the first result of a query transformed by a given function.
	///
	/// - Parameter modelType: The model type over which the first query builder begins.
	/// - Parameter transformation: A function that takes a query builder over all `Model`s and provides a query over the desired `TransformedResult`s.
	public init(startingFrom modelType: Model.Type, firstOf transformation: @escaping Transformation) {
		self.transformation = transformation
		self.evaluation = { query in
			query.first().map(EvaluatedResult.makeOptionalType)
		}
	}
	
}

extension EvaluatableQuery where Model == TransformedResult, EvaluatedResult : OptionalType, EvaluatedResult.WrappedType == TransformedResult {
	
	/// Creates a query that evaluates to the smallest `Model` by some ordering given by a key path.
	///
	/// - Parameter keyPath: The key path from the `Model`s to some value to order the results by.
	public init<T>(smallest keyPath: KeyPath<Model, T>) {
		self.init(startingFrom: Model.self, firstOf: { $0.sort(keyPath, Model.Database.querySortDirectionAscending) })
	}
	
	/// Creates a query that evaluates to the largest `Model` by some ordering given by a key path.
	///
	/// - Parameter keyPath: The key path from the `Model`s to some value to order the results by.
	public init<T>(greatest keyPath: KeyPath<Model, T>) {
		self.init(startingFrom: Model.self, firstOf: { $0.sort(keyPath, Model.Database.querySortDirectionDescending) })
	}
	
}

extension EvaluatableQuery where EvaluatedResult : RangeReplaceableCollection, EvaluatedResult.Element == TransformedResult {
	
	/// Creates a query that evaluates to results of a query transformed by a given function.
	///
	/// - Parameter modelType: The model type over which the query begins.
	/// - Parameter transformation: A function that takes a query over all `Model`s and provides a query over the desired `TransformedResult`s.
	public init(startingFrom type: Model.Type, allOf transformation: @escaping Transformation) {
		self.transformation = transformation
		self.evaluation = { query in
			query.all().map { results in
				if EvaluatedResult.self == Array<TransformedResult>.self {	// avoid copying arrays
					return results as! EvaluatedResult
				} else {
					return EvaluatedResult(results)
				}
			}
		}
	}
	
}

extension EvaluatableQuery where Model == TransformedResult, EvaluatedResult : RangeReplaceableCollection, EvaluatedResult.Element == TransformedResult {
	
	/// Creates a query that evaluates to all `Model`s by some ordering given by a key path.
	///
	/// - Parameter keyPath: The key path from the `Model`s to some value to order the results by.
	/// - Parameter direction: The direction of the ordering. The default value is ascending, i.e., smallest to greatest.
	public init<T>(orderedBy keyPath: KeyPath<Model, T>, _ direction: Model.Database.QuerySortDirection = Model.Database.querySortDirectionAscending) {
		self.init(startingFrom: Model.self, allOf: { $0.sort(keyPath, direction) })
	}
	
}
