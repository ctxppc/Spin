// Spin © 2019–2023 Constantino Tsarouhas

import Conifer
import Foundation
import Spin
import XCTest

final class WelcomePageTestCase : XCTestCase {
	func testHTML() async {
		var graph = ShadowGraph<XMLNode>()
		await graph.render(Button(action: {}) {
			Text("Do thing")
		}, at: .root)
	}
}
