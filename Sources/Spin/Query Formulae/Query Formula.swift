// Spin © 2019 Constantino Tsarouhas

import Vapor

public protocol QueryFormula {
	
	/// The type of values produced by queries with this formula.
	associatedtype Result
	
	/// Evaluates `self` on given connection.
	func result(on connection: DatabaseConnectable) -> Future<Result>
	
}
