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

public typealias AppReducer = Reducer<AppState, AppAction, AppEnvironment>

public let appReducerCore = AppReducer { state, action, environment in
    switch action {
    case .binding: return .none
    case .lifecycle(.active): return .none
    case .lifecycle(.inactive):
        return .run { send in
            await send (.lock(.attemptLock))
        }
    case .lifecycle: return .none
    case .browser(.engine(.themeColorChanged(let color))):
        state.toolbar.backgroundColor = color
        return .none
    case .browser(.engine(.updateEstimatedProgress(let progress))):
        state.toolbar.progress = progress
        return .none
    case .browser(.engine(.didFinishNavigation)):
        state.toolbar.progress = nil
        return .none
    case .browser: return .none
    case .lock: return .none
    case .toolbar(.onSubmit):
        var url = state.toolbar.query.asURL //?? state.searchEngine?.queryUrl(query)
        if let url = url {
            let request = URLRequest(url: url)
            environment.engine.dispatch(.load(request))
        }
        state.showBrowser = true
    return .none
    case .toolbar(.binding(\.$query)):
        state.search.query = state.toolbar.query
        return .none
    case .toolbar(.settingsTapped):
        state.showSettings = true
        return .none
    case .toolbar: return .none
    case .settings(.binding):
        state.search.anchorToBottom = state.toolbar.toolbarPosition == .bottom
        return .none
    case .search(let action):
        return .none
    case .settings: return .none
    case .welcome(.startBrowsing):
        environment.defaults.userHasSeenOnboarding(true)
        state.shouldShowOnboarding = false
        return .none
    }
}
    .binding()
    .telemetry()
    .debugActions(actionFormat: .labelsOnly, environment: \.debug)

public let appReducer = Reducer.combine(
    lifecycleReducer.pullback(
        state: \.lifecycle,
        action: /AppAction.lifecycle,
        environment: { $0 }
    ),
    browserReducer.pullback(
        state: \.browser,
        action: /AppAction.browser,
        environment: \.browser
    ),
    lockReducer.pullback(
        state: \.lock,
        action: /AppAction.lock,
        environment: \.lock
    ),
    searchReducer.pullback(
        state: \.search,
        action: /AppAction.search,
        environment: { _ in .init() }),
    settingsReducer.pullback(
        state: \.settings,
        action: /AppAction.settings,
        environment: { _ in .init() }),
    toolbarReducer.pullback(
        state: \.toolbar,
        action: /AppAction.toolbar,
        environment: \.toolbar),
    appReducerCore
)
