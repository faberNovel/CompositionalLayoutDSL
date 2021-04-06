// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CompositionalLayoutDSL",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "CompositionalLayoutDSL",
            targets: ["CompositionalLayoutDSL"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CompositionalLayoutDSL",
            dependencies: []),
        .testTarget(
            name: "CompositionalLayoutDSLTests",
            dependencies: ["CompositionalLayoutDSL"]
        )
    ]
)
