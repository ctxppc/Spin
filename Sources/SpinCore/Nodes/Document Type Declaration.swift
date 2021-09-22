// Spin © 2019–2021 Constantino Tsarouhas

import Foundation

public struct DocumentTypeDeclaration {
	
	/// Creates a DTD.
	public init() {}
	
}

extension DocumentTypeDeclaration : Node {
	public func serialised<Children : Collection>(children: Children, depth: Int) -> String where Children.Element : Node {
		precondition(children.isEmpty, "DTD subnodes are not supported.")
		return "<!DOCTYPE HTML>"
	}
}
