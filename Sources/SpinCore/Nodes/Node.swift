// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation

/// A child node of an element.
public protocol Node {
	
	/// Returns a serialisation of `self`, suitable for parsing by an HTML parser.
	///
	/// - Parameters:
	///    - children: The children of `self`.
	///    - depth: The indentation depth of `self`.
	///
	/// - Returns: A serialisation of `self`.
	func serialised<Children : Collection>(children: Children, depth: Int) -> String where Children.Element : Node
	
}
