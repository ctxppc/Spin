// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

extension EventLoopFuture {
	
	public static func map(on eventLoop: EventLoop, _ callback: @escaping () throws -> Value) -> EventLoopFuture<Value> {
		
		let promise = eventLoop.makePromise(of: Value.self)
		
		do {
			try promise.succeed(callback())
		} catch {
			promise.fail(error)
		}
		
		return promise.futureResult
		
	}
	
	public static func flatMap(on eventLoop: EventLoop, _ callback: @escaping () throws -> EventLoopFuture<Value>) -> EventLoopFuture<Value> {
		
		let promise = eventLoop.makePromise(of: Value.self)
		
		do {
			try callback().cascade(to: promise)
		} catch {
			promise.fail(error)
		}
		
		return promise.futureResult
		
	}
	
}
