// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

extension Context {
	
	/// The current request.
	public var request: Request {
		self[\.request]
	}
	
}
