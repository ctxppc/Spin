// Spin © 2019 Constantino Tsarouhas

import Fluent

public struct SingleValueQuery<Model : Fluent.Model, Result> {
	
	let queryBuilder: QueryBuilder<Model.Database, Result>
	
	// See protocol.
	public func result(on connection: DatabaseConnectable) -> Future<Result?> {
		
		TODO.unimplemented
	}
	
}
