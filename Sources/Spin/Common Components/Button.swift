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
	
	/// Creates a button containing given text.
	public init(_ text: String) {
		self.init {
			Text(text)
		}
	}
	
	/// Creates a button performing given action and containing given text.
	public init<Action : DifferentiatedAction>(for type: Action.Type, kind: Action.Kind, _ text: String) {
		self.init(for: type, kind: kind) {
			Text(text)
		}
	}
	
}

public protocol DifferentiatedAction : ActionProtocol {
	
	/// A value specifying the kind of action to take.
	associatedtype Kind : RawRepresentable where Kind.RawValue == String
	
	/// The key for encoding the kind.
	static var kindCodingKey: CodingKeys { get }
	
}
