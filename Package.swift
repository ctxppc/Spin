// swift-tools-version:5.2
// Spin © 2019–2020 Constantino Tsarouhas

import PackageDescription

let package = Package(
	name: "Spin",
	platforms: [.macOS(.v10_15)],
	products: [
		.library(name: "Spin", targets: ["SpinCore", "SpinDoc", "SpinHTML"]),
	],
	dependencies: [
		.package(url: "https://github.com/ctxppc/DepthKit.git", .upToNextMinor(from: "0.8.0")),
		.package(url: "https://github.com/vapor/vapor.git", from: "4.3.0"),
		.package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc"),
		.package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
	],
	targets: [
		.target(name: "SpinCore",  dependencies: [
			.product(name: "Vapor", package: "vapor"),
			.product(name: "Fluent", package: "fluent"),
			.product(name: "NIO", package: "swift-nio"),
			"DepthKit",
		]),
		.target(name: "SpinDoc",  dependencies: ["SpinCore", "DepthKit"]),
		.target(name: "SpinHTML",  dependencies: ["SpinCore", "DepthKit"]),
	]
)
