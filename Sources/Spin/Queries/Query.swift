// Spin © 2019 Constantino Tsarouhas

import Fluent

public protocol Query {
	
	associatedtype Result
	
	/// Evaluates `self` on given connection.
	func result(on connection: DatabaseConnectable) -> Future<Result>
	
}
