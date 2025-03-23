// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FunctionCalling-MacPaw-OpenAI",
    platforms: [
        .macOS(.v13),
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FunctionCalling-MacPaw-OpenAI",
            targets: ["FunctionCalling-MacPaw-OpenAI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/FunctionCalling/FunctionCalling", from: "0.5.0"),
        .package(url: "https://github.com/MacPaw/OpenAI", from: "0.3.7")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FunctionCalling-MacPaw-OpenAI",
            dependencies: [
                .product(name: "OpenAI", package: "OpenAI"),
                .product(name: "FunctionCalling", package: "FunctionCalling"),
            ]
        ),
        .testTarget(
            name: "FunctionCalling-MacPaw-OpenAITests",
            dependencies: ["FunctionCalling-MacPaw-OpenAI"]
        ),
    ]
)
