// swift-tools-version:5.1
// Spin © 2019 Constantino Tsarouhas

import PackageDescription

let package = Package(
	name: "Spin",
	products: [
		.library(name: "Spin", targets: ["Spin"]),
	],
	dependencies: [
		.package(url: "https://github.com/ctxppc/DepthKit.git", .upToNextMinor(from: "0.8.0")),
		.package(url: "https://github.com/vapor/vapor.git", from: "3.3.1"),
	],
	targets: [
		.target(name: "Spin",  dependencies: ["Vapor", "DepthKit"]),
	]
)
