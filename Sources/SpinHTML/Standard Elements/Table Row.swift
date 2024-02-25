// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation

/// A component representing an HTML document.
public struct TableRow<Contents : Fragment> : Fragment {
	
	public init(header: Bool = false, @ComponentBuilder contents: @escaping ContentProvider) {
		self.header = header
		self.contents = contents
	}
	
	/// A Boolean value indicating whether the row is a header.
	public let header: Bool
	
	// See protocol.
	public let contents: ContentProvider
	public typealias ContentProvider = @Sendable () -> Contents
	
	// See protocol.
	public var body: some Fragment {
		TODO.unimplemented
	}
	
}

extension TableRow where Contents == Text {

	/// Creates a table row containing given text.
	public init(_ text: String, header: Bool = false) {
		self.init(header: header) {
			Text(text)
		}
	}

}
