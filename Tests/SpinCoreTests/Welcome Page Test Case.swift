// Spin © 2019–2021 Constantino Tsarouhas

import Conifer
import Foundation
import SpinCore
import XCTest

final class WelcomePageTestCase : XCTestCase {
	func testHTML() async {
		var graph = ShadowGraph<XMLNode>()
		await graph.render(Button() {}, at: .root)
	}
}
