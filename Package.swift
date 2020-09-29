// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "E.num",
    products: [
        .library(
            name: "E.num",
            targets: ["E.num"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "E.num",
            dependencies: []),
        .testTarget(
            name: "E.numTests",
            dependencies: ["E.num"]),
    ]
)
