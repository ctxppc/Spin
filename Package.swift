// swift-tools-version:5.5
// Spin © 2019–2020 Constantino Tsarouhas

import PackageDescription

let package = Package(
	name: "Spin",
	platforms: [.macOS(.v12)],
	products: [
		.library(name: "Spin", targets: ["SpinCore", "SpinDoc", "SpinHTML"]),
	],
	dependencies: [
		.package(url: "https://github.com/ctxppc/DepthKit.git", .upToNextMinor(from: "0.9.0")),
		.package(url: "https://github.com/vapor/vapor.git", from: "4.48.2"),
		.package(url: "https://github.com/vapor/fluent.git", from: "4.3.1"),
	],
	targets: [
		.target(name: "SpinCore",  dependencies: [
			.product(name: "Vapor", package: "vapor"),
			.product(name: "Fluent", package: "fluent"),
			"DepthKit",
		]),
		.target(name: "SpinDoc",  dependencies: ["SpinCore", "DepthKit"]),
		.target(name: "SpinHTML",  dependencies: ["SpinCore", "DepthKit"]),
	]
)
