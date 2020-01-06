// Spin © 2019 Constantino Tsarouhas

/// An actionable button in a document.
public struct Button<Contents : Component> : ElementComponent {
	
	/// Creates a button with given contents.
	public init(@ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
	}
	
	/// Creates a button performing given action and containing given contents.
	public init<Action : DifferentiatedAction>(for _: Action.Type, kind: Action.Kind, @ComponentBuilder contents: @escaping () -> Contents) {
		self.contents = contents
		self.attributes = [Action.kindCodingKey.stringValue : kind.rawValue]
	}
	
	// See protocol.
	public let tagName = "button"
	
	// See protocol.
	public var classNames: Set<String> = []
	
	// See protocol.
	public var attributes: [String : String] = [:]
	
	// See protocol.
	public let contents: () -> Contents
	
}

extension Button where Contents == Text {
	
	/// Creates a button containing given label.
	public init(label: String) {
		self.init {
			Text(label)
		}
	}
	
	/// Creates a button performing given action and containing given label.
	public init<Action : DifferentiatedAction>(for type: Action.Type, label: String, kind: Action.Kind) {
		self.init(for: type, kind: kind) {
			Text(label)
		}
	}
	
}

public protocol DifferentiatedAction : ActionProtocol {
	
	/// A value specifying the kind of action to take.
	associatedtype Kind : RawRepresentable where Kind.RawValue == String
	
	/// The key for encoding the kind.
	static var kindCodingKey: CodingKeys { get }
	
}
