// Spin © 2019–2020 Constantino Tsarouhas

import Vapor

extension RoutesBuilder {
	
	/// Registers given locatable component type on the router.
	public func register<Component : LocatableComponent>(_ componentType: Component.Type) {
		registerLocatableComponentType(componentType)
	}
	
	/// Registers given actionable component type on the router.
	public func register<Component : ActionableComponent>(_ componentType: Component.Type) {
		
		// Register GET route for displaying component without associated action.
		registerLocatableComponentType(componentType)
		
		// Register POST route for executing action & presenting results.
		post(componentType.pathComponents) { request throws -> EventLoopFuture<Response> in
			let location: Component.Location = try LocationDecoder.location(from: request.pathComponents)
			let action = try request.content.decode(Component.Action.self)
			return try action.execute(on: request, location: location)
				.flatMap { result in
					Renderer.render(Component(
						location:	location,
						action:		action,
						result:		result
					).context(\.request, request), for: request)
						.serialised(for: request)
				}.flatMapError { error in
					
					// Action.Error errors are expected and passed as-is; other errors are unexpected and logged
					
					let finalError: Component.Action.Error
					if let error = error as? Component.Action.Error {
						finalError = error
					} else {
						request.logger.report(error: error)
						finalError = .unexpected
					}
					
					return Renderer.render(Component(
						location:	location,
						action:		action,
						error:		finalError
					).context(\.request, request), for: request)
						.serialised(for: request)
					
				}
		}
		
	}
	
	/// Registers given locatable component type on the router.
	private func registerLocatableComponentType<Component : LocatableComponent>(_ componentType: Component.Type) {
		get(componentType.pathComponents) { request -> EventLoopFuture<Response> in
			Renderer.render(Component(location: try LocationDecoder.location(from: request.pathComponents)).context(\.request, request), for: request)
				.serialised(for: request)
		}
	}
	
	/// Registers given actionable component type with redirecting actions on the router.
	public func register<Component : ActionableComponent>(_ componentType: Component.Type) where Component.Action : RedirectingAction {
		
		// Register GET route for presenting a component before or after any action has performed.
		get(componentType.pathComponents) { request -> EventLoopFuture<Response> in
			
			let location = try LocationDecoder.location(ofType: Component.Location.self, from: request.pathComponents)
			
			let component: Component
			do {
				let status = try request.query.decode(RedirectingActionStatus<Component.Action>.self)
				if let result = status.result {
					component = Component(location: location, action: status.action, result: result)
				} else if let error = status.error {
					component = Component(location: location, action: status.action, error: error)
				} else {
					component = Component(location: location, action: status.action, error: .unexpected)
				}
			} catch {	// no action available (or invalid query string)
				component = Component(location: location)
			}
			
			return Renderer.render(component.context(\.request, request), for: request)
				.serialised(for: request)
			
		}
		
		// Register POST route for executing an action and then producing a redirect response.
		post(componentType.pathComponents) { request -> EventLoopFuture<Response> in
			let location: Component.Location = try LocationDecoder.location(from: request.pathComponents)
			let action = try request.content.decode(Component.Action.self)
			return try action.execute(on: request, location: location)
				.flatMapThrowing { result -> Response in
					let newLocation = action.location(for: result, originalLocation: location)
					let status = RedirectingActionStatus(action: action, result: result, error: nil)
					return request.redirect(to: try Component.Action.url(for: status, location: newLocation).absoluteString, type: .normal)
				}.flatMapErrorThrowing { error in
					
					// Action.Error errors are expected and passed as-is; other errors are unexpected and logged
					
					let finalError: Component.Action.Error
					if let error = error as? Component.Action.Error {
						finalError = error
					} else {
						request.logger.report(error: error)
						finalError = .unexpected
					}
					
					let newLocation = action.location(for: finalError, originalLocation: location)
					let status = RedirectingActionStatus(action: action, result: nil, error: finalError)
					return request.redirect(to: try Component.Action.url(for: status, location: newLocation).absoluteString, type: .normal)
					
				}
		}
		
	}
	
}

extension RoutesBuilder {
	
	fileprivate func get(_ path: [PathComponent], use response: @escaping (Request) throws -> EventLoopFuture<Response>) {
		on(.GET, path, use: response)
	}
	
	fileprivate func post(_ path: [PathComponent], use response: @escaping (Request) throws -> EventLoopFuture<Response>) {
		on(.POST, path, use: response)
	}
	
	fileprivate func on(_ method: HTTPMethod, _ path: [PathComponent], use response: @escaping (Request) throws -> EventLoopFuture<Response>) {
		add(Route(method: method, path: path, responder: BasicResponder { try response($0).encodeResponse(for: $0) }, requestType: Request.self, responseType: Response.self))
	}
	
}

extension EventLoopFuture where Value == [Node] {
	fileprivate func serialised(for request: Request) -> EventLoopFuture<Response> {
		map { nodes in
			let body = nodes.map {
				$0.stringRepresentation(depth: 0, renderingRootInline: false)
			}.joined(separator: "\n")
			return Response(headers: ["Content-Type": "text/html; charset=utf-8"], body: Response.Body(string: body))
		}
	}
}


extension LocatableComponent {
	static var pathComponents: [PathComponent] {
		Location.pathComponents.map { component in
			switch component {
				case .literal(let literal):		return .constant(literal)
				case .parameter(key: let key):	return .parameter(key.stringValue)
			}
		}
	}
}

extension Request {
	fileprivate var pathComponents: ArraySlice<String> {
		url.path.components(separatedBy: "/").dropFirst()
	}
}
