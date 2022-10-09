//
//  File.swift
//  
//
//  Created by Jeff Boek on 10/1/22.
//

import Foundation
import RegexBuilder

import ComposableArchitecture

import LibAppStore
import LibBiometrics
import LibContentBlocker
import LibCrash
import LibDefaults
import LibEngine
import LibExperiments
import LibSearchEngines
import LibSearchSuggestions
import LibTelemetry

import FeatureBrowser
import FeatureLock
import FeatureSearch
import FeatureSettings
import FeatureToolbar
import FeatureWelcome

public struct AppEnvironment {
    var appStore: LibAppStore.AppStore
    var biometrics: Biometrics
    var contentBlocker: ContentBlocker
    var crash: Crash
    var date: () -> Date
    var defaults: Defaults
    var engine: Engine
    var experiments: Experiments
    var searchEngines: SearchEngines
    var searchSuggestionsClient: SearchSuggestionsClient
    var telemetry: Telemetry
}

extension AppEnvironment {
    static var live: AppEnvironment {
        .init(
            appStore: .live,
            biometrics: .live(),
            contentBlocker: .live(bundleIdentifier: "us.boek.Scout.ContentBlocker"),
            crash: .live,
            date: { Date() },
            defaults: .live(),
            engine: .system,
            experiments: .live,
            searchEngines: .localeAware(),
            searchSuggestionsClient: .live,
            telemetry: .live
        )
    }

    static var test: AppEnvironment {
        .init(
            appStore: .test,
            biometrics: .test,
            contentBlocker: .test,
            crash: .test,
            date: { .distantPast },
            defaults: .testAlwaysFalse,
            engine: .test,
            experiments: .test,
            searchEngines: .test,
            searchSuggestionsClient: .test,
            telemetry: .test
        )
    }

    var lifecycle: Self { self }

    var browser: BrowserEnvironment {
        .init(engine: engine)
    }

    var lock: LockEnvironment {
        .init(biometrics: biometrics)
    }

    var search: SearchEnvironment {
        .init(
            searchSuggestionsClient: searchSuggestionsClient
        )
    }

    var settings: SettingsEnvironment {
        .init()
    }

    var toolbar: ToolbarEnvironment {
        .init()
    }

    var debug: DebugEnvironment {
        let regex = Regex {
            OneOrMore {
                ChoiceOf {
                    "\n"
                    "  "
                }
            }
        }

        return .init(
            printer: {
                print(
                    "🏪",
                    $0.replacing(regex, with: " ")
                )
            }
        )
    }
}
