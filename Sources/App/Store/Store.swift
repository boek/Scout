//
//  File.swift
//  
//
//  Created by Jeff Boek on 10/1/22.
//

import Foundation
import ComposableArchitecture

import FeatureBrowser
import FeatureLock
import FeatureSearch
import FeatureSettings
import FeatureToolbar
import FeatureWelcome

public typealias AppStore = Store<AppState, AppAction>

extension AppStore {
    public static var live: AppStore {
        .init(
            initialState: .initial,
            reducer: appReducer,
            environment: AppEnvironment.live
        )
    }

    var browser: BrowserStore {
        scope(state: \.browser, action: AppAction.browser)
    }

    var lock: LockStore {
        scope(state: \.lock, action: AppAction.lock)
    }

    var search: SearchStore {
        scope(state: \.search, action: AppAction.search)
    }

    var settings: SettingsStore {
        scope(state: \.settings, action: AppAction.settings)
    }

    var toolbar: ToolbarStore {
        scope(state: \.toolbar, action: AppAction.toolbar)
    }

    var welcome: WelcomeStore {
        scope(state: { _ in () }, action: AppAction.welcome)
    }
}
