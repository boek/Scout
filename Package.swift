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

        .library(name: "LibBiometrics", targets: ["LibBiometrics"]),
        .library(name: "LibCrash", targets: ["LibCrash"]),
        .library(name: "LibEngine", targets: ["LibEngine"]),
        .library(name: "LibExperiments", targets: ["LibExperiments"]),
        .library(name: "LibDefaults", targets: ["LibDefaults"]),
        .library(name: "LibSearchEngine", targets: ["LibSearchEngine"]),
        .library(name: "LibSearchSuggestions", targets: ["LibSearchSuggestions"]),
        .library(name: "LibTelemetry", targets: ["LibTelemetry"]),
        .library(name: "LibUI", targets: ["LibUI"]),

        .library(name: "FeatureBrowser", targets: ["FeatureBrowser"]),
        .library(name: "FeatureHome", targets: ["FeatureHome"]),
        .library(name: "FeatureLock", targets: ["FeatureLock"]),
        .library(name: "FeatureSearch", targets: ["FeatureSearch"]),
        .library(name: "FeatureSettings", targets: ["FeatureSettings"]),
        .library(name: "FeatureTips", targets: ["FeatureTips"]),
        .library(name: "FeatureToolbar", targets: ["FeatureToolbar"]),
        .library(name: "FeatureWelcome", targets: ["FeatureWelcome"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.39.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            "LibBiometrics",
            "LibCrash",
            "LibDefaults",
            "LibEngine",
            "LibExperiments",
            "LibSearchEngine",
            "LibSearchSuggestions",
            "LibTelemetry",
            "FeatureBrowser",
            "FeatureHome",
            "FeatureLock",
            "FeatureSearch",
            "FeatureSettings",
            "FeatureToolbar",
            "FeatureWelcome",
            .tca
        ]),

        .target(name: "LibBiometrics", dependencies: []),
        .target(name: "LibCrash", dependencies: []),
        .target(name: "LibEngine", dependencies: []),
        .target(name: "LibExperiments", dependencies: []),
        .target(name: "LibDefaults", dependencies: []),
        .target(name: "LibSearchEngine", dependencies: []),
        .target(name: "LibSearchSuggestions", dependencies: ["LibSearchEngine"]),
        .testTarget(name: "LibSearchSuggestionsTests", dependencies: ["LibSearchSuggestions"]),
        .target(name: "LibTelemetry", dependencies: []),
        .target(name: "LibUI", dependencies: []),

        .target(name: "FeatureBrowser", dependencies: [
            "LibEngine",
            .tca
        ]),
        .target(name: "FeatureHome", dependencies: [
            "LibUI",
            .tca
        ]),
        .target(name: "FeatureLock", dependencies: [
            "LibBiometrics",
            "LibUI",
            .tca
        ]),
        .target(name: "FeatureSearch", dependencies: [
            "LibUI",
            .tca
        ]),
        .target(name: "FeatureSettings", dependencies: [
            "LibUI",
            .tca
        ]),
        .target(name: "FeatureTips", dependencies: [
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
