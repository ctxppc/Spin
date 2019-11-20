// Spin © 2019 Constantino Tsarouhas

import Fluent

public struct ListQueryFormula<Model : Fluent.Model, Element> : QueryFormula {
	
	/// A function that takes a connectable value and produces a query builder.
	public let queryBuilder: (DatabaseConnectable) -> QueryBuilder<Model.Database, Element>
	
	// See protocol.
	public func result(on connection: DatabaseConnectable) -> Future<[Element]> {
		queryBuilder(connection).all()
	}
	
}

extension Model {
	
	/// Returns a formula for querying all instances of this model on a database, ordered by given key path.
	public static func all<Value>(orderedBy keyPath: KeyPath<Self, Value>, _ direction: Database.QuerySortDirection = Database.querySortDirectionAscending) -> some QueryFormula {
		ListQueryFormula<Self, Self> {
			Self.query(on: $0).sort(keyPath, direction)
		}
	}
	
}
