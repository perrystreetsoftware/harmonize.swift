// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Harmonize",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "Harmonize",
            targets: ["Harmonize"]
        )
    ],
    dependencies: [
//        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
        .package(url: "https://github.com/sjavora/swift-syntax-xcframeworks.git", from: "509.0.2"),

    ],
    targets: [
        .target(
            name: "Harmonize",
            dependencies: [
//                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
//                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
                .product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks")
            ]
        ),
        .testTarget(
            name: "HarmonizeTests",
            dependencies: [
                "Harmonize",
//                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                .product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks"),
            ]
        )
    ]
)
