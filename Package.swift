// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "E",
    products: [
        .library(
            name: "E",
            targets: ["E"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "E",
            dependencies: []),
        .testTarget(
            name: "ETests",
            dependencies: ["E"]),
    ]
)
