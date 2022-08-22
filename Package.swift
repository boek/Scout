// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let tca = Target.Dependency.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
let package = Package(
    name: "Scout",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "App", targets: ["App"]),

        .library(name: "LibDefaults", targets: ["LibDefaults"]),

        .library(name: "FeatureWelcome", targets: ["FeatureWelcome"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.39.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            "LibDefaults",
            "FeatureWelcome",
            tca
        ]),

        .target(name: "LibDefaults", dependencies: []),

        .target(name: "FeatureWelcome", dependencies: [
            "LibDefaults",
            tca
        ]),
    ]
)
