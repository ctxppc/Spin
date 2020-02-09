// swift-tools-version:5.1
// Spin © 2019–2020 Constantino Tsarouhas

import PackageDescription

let package = Package(
	name: "Spin",
	platforms: [.macOS(.v10_15)],
	products: [
		.library(name: "Spin", targets: ["SpinCore", "SpinHTML"]),
	],
	dependencies: [
		.package(url: "https://github.com/ctxppc/DepthKit.git", .upToNextMinor(from: "0.8.0")),
		.package(url: "https://github.com/vapor/vapor.git", from: "3.3.1"),
		.package(url: "https://github.com/vapor/fluent.git", from: "3.0.0"),
	],
	targets: [
		.target(name: "SpinCore",  dependencies: ["Vapor", "DepthKit", "Fluent"]),
		.target(name: "SpinHTML",  dependencies: ["SpinCore", "DepthKit"]),
	]
)
