// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Harmonize",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "Harmonize", targets: ["Harmonize"]),
        .library(name: "Semantics", targets: ["Semantics"]),
        .library(name: "Utils", targets: ["Utils"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "509.0.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.1.3")
    ],
    targets: [
        .target(
            name: "Harmonize",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
                "Yams",
                "Semantics",
                "Utils"
            ]
        ),
        .target(
            name: "Semantics",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax")
            ]
        ),
        .target(name: "Utils"),
        .testTarget(name: "HarmonizeTests", dependencies: ["Harmonize"]),
        .testTarget(name: "SemanticsTests", dependencies: ["Semantics"])
    ]
)
