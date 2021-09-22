// swift-tools-version:5.5
// Spin © 2019–2021 Constantino Tsarouhas

import PackageDescription

let package = Package(
	name: "Spin",
	platforms: [.macOS(.v12)],
	products: [
		.library(name: "Spin", targets: ["SpinCore"]),
	],
	dependencies: [
		.package(url: "https://github.com/ctxppc/DepthKit.git", .upToNextMinor(from: "0.10.0")),
		.package(url: "https://bitbucket.org/ctxppc/conifer.git", branch: "development"),
	],
	targets: [
		.target(name: "SpinCore",  dependencies: [
			"DepthKit",
			.product(name: "Conifer", package: "conifer"),
		]),
	]
)
