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
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(name: "App", targets: ["App"]),

        .library(name: "LibBiometrics", targets: ["LibBiometrics"]),
        .library(name: "LibContentBlocker", targets: ["LibContentBlocker"]),
        .library(name: "LibCrash", targets: ["LibCrash"]),
        .library(name: "LibEngine", targets: ["LibEngine"]),
        .library(name: "LibExperiments", targets: ["LibExperiments"]),
        .library(name: "LibDefaults", targets: ["LibDefaults"]),
        .library(name: "LibSearchEngines", targets: ["LibSearchEngines"]),
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
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.40.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            "LibBiometrics",
            "LibCrash",
            "LibDefaults",
            "LibEngine",
            "LibExperiments",
            "LibSearchEngines",
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

        .target(name: "LibBiometrics"),
        .target(
            name: "LibContentBlocker",
            resources: [
                .process("./Resources/Blocklists")
            ]
        ),
        .testTarget(
            name: "LibContentBlockerTests",
            dependencies: ["LibContentBlocker"]
        ),
        .target(name: "LibCrash"),
        .target(name: "LibEngine"),
        .target(name: "LibExperiments"),
        .target(name: "LibDefaults"),
        .target(
            name: "LibSearchEngines",
            resources: [
                .copy("./Resources/Plugins"),
                .process("./Resources/SearchEngines.plist")
            ]
        ),
        .testTarget(
            name: "LibSearchEnginesTests",
            dependencies: ["LibSearchEngines"]
        ),
        .target(
            name: "LibSearchSuggestions",
            dependencies: ["LibSearchEngines"]
        ),
        .testTarget(
            name: "LibSearchSuggestionsTests",
            dependencies: ["LibSearchSuggestions"]
        ),
        .target(name: "LibTelemetry"),
        .target(name: "LibUI"),

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
        .testTarget(
            name: "FeatureLockTests",
            dependencies: ["FeatureLock"]
        ),
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
