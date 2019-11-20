// Spin © 2019 Constantino Tsarouhas

import Vapor

extension Context {
	
	/// The current request.
	public var request: Request {
		self[\.request]
	}
	
}
