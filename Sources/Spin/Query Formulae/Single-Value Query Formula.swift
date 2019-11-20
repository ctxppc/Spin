// Spin © 2019 Constantino Tsarouhas

import Fluent

public struct SingleValueQueryFormula<Model : Fluent.Model, Value> : QueryFormula {
	
	/// A function that takes a connectable value and produces a query builder.
	public let queryBuilder: (DatabaseConnectable) -> QueryBuilder<Model.Database, Value>
	
	// See protocol.
	public func result(on connection: DatabaseConnectable) -> Future<Value?> {
		queryBuilder(connection).first()
	}
	
}

extension Model {
	
	/// Returns a formula for querying the first instance of this model on a database, ordered by given key path.
	public static func first<Value>(orderedBy keyPath: KeyPath<Self, Value>) -> some QueryFormula {
		SingleValueQueryFormula<Self, Self> {
			Self.query(on: $0).sort(keyPath, Database.querySortDirectionAscending)
		}
	}
	
	/// Returns a formula for querying the last instance of this model on a database, ordered by given key path.
	public static func last<Value>(orderedBy keyPath: KeyPath<Self, Value>) -> some QueryFormula {
		SingleValueQueryFormula<Self, Self> {
			Self.query(on: $0).sort(keyPath, Database.querySortDirectionDescending)
		}
	}
	
}
