// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeychainStorage",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "KeychainStorage",
            targets: ["KeychainStorage"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "KeychainStorage",
            dependencies: []),
        .testTarget(
            name: "KeychainStorageTests",
            dependencies: ["KeychainStorage", "KeychainStorageHost"]),
    ],
    swiftLanguageVersions: [.v5]
)
