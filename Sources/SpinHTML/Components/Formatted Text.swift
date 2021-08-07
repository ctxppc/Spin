// Spin © 2019–2021 Constantino Tsarouhas

import SpinCore

public struct FormattedText : Component {
	
	/// Creates a formatted text component.
	public init(spans: [Span] = []) {
		self.spans = spans
	}
	
	/// The formatted text's spans.
	public var spans: [Span]
	public enum Span {
		case normal(String)
		case emphasised(String)
		case stronglyEmphasised(String)
	}
	
	// See protocol.
	public var body: some Component {
		EmptyComponent()
	}
	
	// See protocol.
	public func render(into renderer: inout Renderer) {
		for segment in spans {
			switch segment {
				case .normal(let text):				renderer.addNode(HTMLTextNode(text))
				case .emphasised(let text):			renderer.addNode(HTMLElement(tagName: "em", subnodes: [HTMLTextNode(text)]))
				case .stronglyEmphasised(let text):	renderer.addNode(HTMLElement(tagName: "strong", subnodes: [HTMLTextNode(text)]))
			}
		}
	}
	
}

extension FormattedText : ExpressibleByStringInterpolation {
	
	// See protocol.
	public init(stringLiteral: String) {
		self.init(spans: [.normal(stringLiteral)])
	}
	
	// See protocol.
	public init(stringInterpolation: StringInterpolation) {
		self.init(spans: stringInterpolation.spans)
	}
	
	// See protocol.
	public struct StringInterpolation : StringInterpolationProtocol {
		
		// See protocol.
		public init(literalCapacity: Int, interpolationCount: Int) {
			spans = []
			spans.reserveCapacity(interpolationCount)
		}
		
		/// The formatted text's spans.
		fileprivate var spans: [Span]
		
		/// Appends a span of text in normal formatting.
		public mutating func appendLiteral(_ text: String) {
			spans.append(.normal(text))
		}
		
		/// Appends a span of emphasised text.
		public mutating func appendInterpolation(emphasised text: String, strongly: Bool = false) {
			spans.append(strongly ? .stronglyEmphasised(text) : .emphasised(text))
		}
		
	}
	
}
