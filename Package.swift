// swift-tools-version:5.7
// Spin © 2019–2023 Constantino Tsarouhas

import PackageDescription

let package = Package(
	name: "Spin",
	platforms: [.macOS(.v12)],
	products: [
		
		/// A library for composing web applications from semantic building blocks.
		.library(name: "Spin", targets: ["Spin"]),
		
		/// A library for composing HTML documents from standard elements.
		.library(name: "SpinHTML", targets: ["SpinHTML"]),
		
	],
	dependencies: [
		.package(url: "https://bitbucket.org/ctxppc/conifer.git", branch: "development"),
		.package(url: "https://github.com/ctxppc/DepthKit.git", .upToNextMinor(from: "0.10.0")),
	],
	targets: [
		.target(name: "Spin", dependencies: [
			"SpinHTML"
		]),
		.target(name: "SpinHTML", dependencies: [
			"DepthKit",
			.product(name: "Conifer", package: "conifer"),
		]),
		.testTarget(name: "SpinHTMLTests", dependencies: ["SpinHTML"]),
	]
)
