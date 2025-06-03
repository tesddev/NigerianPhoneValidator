// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NigerianPhoneValidator",
    platforms: [
        .iOS(.v13),
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
            dependencies: []),
        .testTarget(
            name: "NigerianPhoneValidatorTests",
            dependencies: ["NigerianPhoneValidator"]),
    ]
)
