// Spin © 2019 Constantino Tsarouhas

import Vapor

extension Router {
	
	/// Registers given component type on the router.
	public func register<Component : LocatableComponent>(_ componentType: Component.Type) {
		registerLocatableComponentType(componentType)
	}
	
	/// Registers given component type on the router.
	private func registerLocatableComponentType<Component : LocatableComponent>(_ componentType: Component.Type) {
		register(route: Route(path: componentType.pathComponents(for: .GET), output: BasicResponder { request in
			Renderer.render(Component(location: try LocationDecoder.location(from: request.http.url.pathComponents.dropFirst())).context(\.request, request), for: request)
				.serialised(for: request)
		}))
	}
	
	/// Registers given component type on the router.
	public func register<Component : ActionableComponent>(_ componentType: Component.Type) {
		registerLocatableComponentType(componentType)
		register(route: Route(path: componentType.pathComponents(for: .POST), output: BasicResponder { request in
			let location: Component.Location = try LocationDecoder.location(from: request.http.url.pathComponents.dropFirst())
			return try request.content.decode(Component.Action.self)
				.flatMap { $0.execute(on: request, location: location) }
				.flatMap { result in
					Renderer.render(Component(
						location:	location,
						result:		result
					).context(\.request, request), for: request).serialised(for: request)
				}
		}))
	}
	
}

extension Future where T == [Node] {
	fileprivate func serialised(for request: Request) -> Future<Response> {
		map { nodes in
			let body = nodes.map {
				$0.stringRepresentation(depth: 0, renderingRootInline: false)
			}.joined(separator: "\n")
			return Response(
				http:	.init(headers: ["Content-Type": "text/html; charset=utf-8"], body: body),
				using:	request
			)
		}
	}
}


extension LocatableComponent {
	static func pathComponents(for method: HTTPMethod) -> [PathComponent] {
		[PathComponent.constant(method.string)]
			+ Location.pathComponents.map { component in
				switch component {
					case .literal(let literal):		return .constant(literal)
					case .parameter(key: let key):	return .parameter(key.stringValue)
				}
			}
	}
}

extension LocationPathComponent : PathComponentsRepresentable {
	public func convertToPathComponents() -> [PathComponent] {
		switch self {
			case .literal(let literal):		return [.constant(literal)]
			case .parameter(key: let key):	return [.parameter(key.stringValue)]
		}
	}
}
