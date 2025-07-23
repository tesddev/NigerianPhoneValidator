// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NigerianPhoneValidator",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "NigerianPhoneValidator",
            targets: ["NigerianPhoneValidator"]),
    ],
    dependencies: [
        // Add any dependencies here if needed
    ],
    targets: [
        .target(
            name: "NigerianPhoneValidator",
            dependencies: [],
            swiftSettings: [
                .define("SWIFT_PACKAGE"),
                .define("ARM64_SIMULATOR", .when(platforms: [.iOS], configuration: .debug)),
                .define("X86_64_SIMULATOR", .when(platforms: [.iOS], configuration: .debug))
            ]),
        .testTarget(
            name: "NigerianPhoneValidatorTests",
            dependencies: ["NigerianPhoneValidator"]),
    ]
)