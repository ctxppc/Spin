// swift-tools-version:5.9
// Spin © 2019–2024 Constantino Tsarouhas

import PackageDescription

let package = Package(
	name: "Spin",
	platforms: [.macOS(.v14)],
	products: [
		
		/// A library for composing web applications from semantic building blocks.
		.library(name: "Spin", targets: ["Spin"]),
		
		/// A library for composing HTML documents from standard elements.
		.library(name: "SpinHTML", targets: ["SpinHTML"]),
		
		/// A library for composing XML documents.
		.library(name: "SpinXML", targets: ["SpinXML"]),
		
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
			"SpinXML"
		]),
		.testTarget(name: "SpinHTMLTests", dependencies: ["SpinHTML"]),
		
		.target(name: "SpinXML", dependencies: [
			"DepthKit",
			.product(name: "Conifer", package: "conifer"),
		]),
		
	]
)
