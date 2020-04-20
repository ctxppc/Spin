// Harmony © 2019 Michael Theodoridis

import Fluent
import Vapor

/// A model value that specifies access permissions.
public protocol ControlledModel : Model {
	
	/// Returns a value determining whether the value can be read and written for given request.
	///
	/// The permission is only granted on the value as it is. Changing any part of the model value can invalidate the permission.
	func accessPermission(on request: Request) throws -> AccessPermission
	
}

public enum AccessPermission : Int, Comparable, Hashable {
	
	/// The value cannot be accessed.
	case none
	
	/// The value can be read but not saved.
	case read
	
	/// The value can be read & saved.
	case full
	
	// See protocol.
	public static func < (lowerPermission: Self, higherPermission: Self) -> Bool {
		lowerPermission.rawValue < higherPermission.rawValue
	}
	
}

extension ControlledModel {
	
	/// Retrieves a value and validates its read permission on given request.
	public static func authenticatedFind(_ identifier: IDValue, on request: Request) -> EventLoopFuture<Self?> {
		Self.find(identifier, on: request.db).flatMapThrowing { value in
			guard let value = value else { return nil }
			try value.requirePermission(.read, on: request)
			return value
		}
	}
	
	/// Creates the value in the database after validating its write permission on the given request.
	public func authenticatedCreate(on request: Request) -> EventLoopFuture<()> {
		EventLoopFuture.flatMap(on: request.eventLoop) {
			try self.requirePermission(.full, on: request)
			return self.create(on: request.db)
		}
	}
	
	/// Saves the value in the database after validating its write permission on the given request.
	public func authenticatedSave(on request: Request) -> EventLoopFuture<()> {
		EventLoopFuture.flatMap(on: request.eventLoop) {
			try self.requirePermission(.full, on: request)
			return self.save(on: request.db)
		}
	}
	
	/// Updates the value on the database after validating its write permission on the given request.
	public func authenticatedUpdate(on request: Request) -> EventLoopFuture<()> {
		EventLoopFuture.flatMap(on: request.eventLoop) {
			try self.requirePermission(.full, on: request)
			return self.update(on: request.db)
		}
	}
	
	/// Deletes the value on the database after validating its write permission on the given request.
	public func authenticatedDelete(on request: Request, force: Bool = false) -> EventLoopFuture<()> {
		EventLoopFuture.flatMap(on: request.eventLoop) {
			try self.requirePermission(.full, on: request)
			return self.delete(force: force, on: request.db)
		}
	}
	
	/// Validates whether given request has at least given permission.
	public func requirePermission(_ permission: AccessPermission, on request: Request) throws {
		guard try accessPermission(on: request) >= permission else { throw ModelSavingError.unauthorised() }
	}
	
}

public enum ModelRetrievalError : AbortError {
	
	/// The value could not be found.
	case notFound(errorIdentifier: String = UUID().uuidString)
	
	/// The value is not permitted to be read on the current request.
	case unauthorised(errorIdentifier: String = UUID().uuidString)
	
	// See protocol.
	public var status: HTTPResponseStatus {
		switch self {
			case .notFound:		return .notFound
			case .unauthorised:	return .unauthorized
		}
	}
	
	// See protocol.
	public var reason: String {
		switch self {
			case .notFound:		return "Couldn't find a suitable value in the persistent store."
			case .unauthorised:	return "You do not have sufficient permissions to read this value from the persistent store."
		}
	}
	
	// See protocol.
	public var identifier: String {
		switch self {
			case .notFound(let i):		return i
			case .unauthorised(let i):	return i
		}
	}
	
}

public enum ModelSavingError : AbortError {
	
	/// The value is not permitted to be saved on the current request.
	case unauthorised(errorIdentifier: String = UUID().uuidString)
	
	// See protocol.
	public var status: HTTPResponseStatus {
		switch self {
			case .unauthorised:	return .unauthorized
		}
	}
	
	// See protocol.
	public var reason: String {
		switch self {
			case .unauthorised:	return "You do not have sufficient permissions to store this value in the persistent store."
		}
	}
	
	// See protocol.
	public var identifier: String {
		switch self {
			case .unauthorised(let i):	return i
		}
	}
	
}
