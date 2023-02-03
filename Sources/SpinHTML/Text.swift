// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation

/// A text fragment.
public struct Text : Fragment {
	
	/// Creates a text fragment with given value.
	public init(_ value: String) {
		self.value = value
	}
	
	/// The text fragment's value.
	public var value: String
	
	// See protocol.
	public var body: Never {
		Never.hasNoBody(self)
	}
	
	// See protocol.
	public func render<G>(in graph: inout G, at location: ShadowGraphLocation) async where G : ShadowGraphProtocol {
		graph.produce(XMLNode.text(withStringValue: value) as! G.Artefact, at: location)
	}
	
}

extension String {
	
	/// A literal representation of `self` suitable for insertion into an HTML context.
	///
	/// - Complexity: O(*n*) where *n* is the number of characters in `self`.
	func htmlEscaped() -> String {
		map { entitiesByEscapedCharacters[$0] ?? String($0) }.joined()
	}
	
}

private let entitiesByEscapedCharacters: [Character : String] = [
	"<" :	"&lt;",
	">" : 	"&gt;",
	#"\"# :	"&quot;",
	"'" :	"&#x27;",
	"/" :	"&#x2F;",
]
