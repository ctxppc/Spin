// Spin © 2019–2024 Constantino Tsarouhas

import Conifer
import Foundation
import SpinHTML
import XCTest

final class WelcomePageTestCase : XCTestCase {
	func testHTML() async {
		var graph = ShadowGraph<XMLNode>()
		await graph.render(Button {
			Text("Do thing")
		}, at: .root)
	}
}
