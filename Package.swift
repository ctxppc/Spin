// swift-tools-version:5.9
// Spin © 2019–2024 Constantino Tsarouhas

import PackageDescription

let package = Package(
	name: "Spin",
	platforms: [.macOS(.v14)],
	products: [
		
		/// A library for composing web applications from semantic building blocks.
		.library(name: "SpinCore", targets: ["SpinCore"]),
		
		/// A library for composing HTML documents from standard elements.
		.library(name: "SpinHTML", targets: ["SpinHTML"]),
		
	],
	dependencies: [
		.package(url: "https://bitbucket.org/ctxppc/conifer.git", branch: "development"),
		.package(url: "https://github.com/ctxppc/DepthKit.git", .upToNextMinor(from: "0.10.0")),
	],
	targets: [
		.target(name: "SpinCore", dependencies: [
			"SpinHTML"
		]),
		.target(name: "SpinHTML", dependencies: [
			"DepthKit",
			.product(name: "Conifer", package: "conifer"),
		]),
		.testTarget(name: "SpinHTMLTests", dependencies: ["SpinHTML"]),
	]
)
