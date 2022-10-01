//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import Foundation

import ComposableArchitecture

import LibBiometrics
import LibCrash
import LibDefaults
import LibEngine
import LibExperiments
import LibSearchEngines
import LibTelemetry

import FeatureBrowser
import FeatureLock
import FeatureSearch
import FeatureSettings
import FeatureToolbar
import FeatureWelcome

extension FeatureToolbar.ToolbarPosition {
    var settingsPosition: FeatureSettings.ToolbarPosition {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }

    init(_ settingsPosition: FeatureSettings.ToolbarPosition) {
        switch settingsPosition {
        case .bottom: self = .bottom
        case .top: self = .top
        }
    }
}

public struct AppState: Equatable {
    @BindableState var shouldShowOnboarding: Bool
    @BindableState var showSettings: Bool
    var showBrowser: Bool
    var browser: BrowserState
    var lock: LockState
    var search: SearchState
    var toolbar: ToolbarState

    var settings: SettingsState {
        get {
            .init(
                toolbarPosition: toolbar.toolbarPosition.settingsPosition,
                lockEnabled: lock.isEnabled
            )
        }
        set {
            toolbar.toolbarPosition = .init(newValue.toolbarPosition)
            lock.isEnabled = newValue.lockEnabled
        }
    }
}

extension AppState {
    static var initial: AppState {
        .init(
            shouldShowOnboarding: false,
            showSettings: false,
            showBrowser: false,
            browser: .inert,
            lock: .initial,
            search: .initial,
            toolbar: .initial
        )
    }
}

extension AppState {
    var lifecycle: LifecycleState {
        get {
            .init(
                shouldLock: lock.isEnabled,
                shouldShowOnboarding: shouldShowOnboarding
            )
        }
        set {
            lock.isEnabled = newValue.shouldLock
            shouldShowOnboarding = newValue.shouldShowOnboarding
        }
    }
}
