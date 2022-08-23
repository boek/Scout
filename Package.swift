// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Target.Dependency {
    static var tca: Target.Dependency {
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    }
}

let package = Package(
    name: "Scout",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "App", targets: ["App"]),

        .library(name: "LibDefaults", targets: ["LibDefaults"]),
        .library(name: "LibUI", targets: ["LibUI"]),

        .library(name: "FeatureHome", targets: ["FeatureHome"]),
        .library(name: "FeatureSettings", targets: ["FeatureSettings"]),
        .library(name: "FeatureToolbar", targets: ["FeatureToolbar"]),
        .library(name: "FeatureWelcome", targets: ["FeatureWelcome"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.39.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            "LibDefaults",
            "FeatureHome",
            "FeatureSettings",
            "FeatureToolbar",
            "FeatureWelcome",
            .tca
        ]),

        .target(name: "LibDefaults", dependencies: []),
        .target(name: "LibUI", dependencies: []),

        .target(name: "FeatureHome", dependencies: [
            "LibUI",
            .tca
        ]),
        .target(name: "FeatureSettings", dependencies: [
            "LibUI",
            .tca
        ]),
        .target(name: "FeatureToolbar", dependencies: [
            "LibUI",
            .tca
        ]),
        .target(name: "FeatureWelcome", dependencies: [
            "LibDefaults",
            "LibUI",
            .tca
        ]),
    ]
)
