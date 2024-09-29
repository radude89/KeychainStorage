// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeychainStorage",
    platforms: [
            .macOS(.v15), .iOS(.v18), .tvOS(.v18)
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "KeychainStorage",
            targets: ["KeychainStorage"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "KeychainStorage"),
        .testTarget(
            name: "KeychainStorageTests",
            dependencies: ["KeychainStorage"]
        ),
    ]
)