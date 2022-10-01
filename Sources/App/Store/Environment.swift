//
//  File.swift
//  
//
//  Created by Jeff Boek on 10/1/22.
//

import Foundation
import RegexBuilder

import ComposableArchitecture

import LibBiometrics
import LibCrash
import LibDefaults
import LibEngine
import LibExperiments
import LibTelemetry

import FeatureBrowser
import FeatureLock
import FeatureSearch
import FeatureSettings
import FeatureToolbar
import FeatureWelcome

public struct AppEnvironment {
    var biometrics: Biometrics
    var crash: Crash
    var defaults: Defaults
    var engine: Engine
    var experiments: Experiments
    var telemetry: Telemetry
}

extension AppEnvironment {
    static var live: AppEnvironment {
        .init(
            biometrics: .live,
            crash: .live,
            defaults: .live,
            engine: .system,
            experiments: .live,
            telemetry: .live
        )
    }

    var browser: BrowserEnvironment {
        .init(engine: engine)
    }

    var lock: LockEnvironment {
        .init(biometrics: biometrics)
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
