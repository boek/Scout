//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture

import LibDefaults

import FeatureLock
import FeatureSearch
import FeatureSettings
import FeatureToolbar
import FeatureWelcome

public typealias AppStore   = Store<AppState, AppAction>
public typealias AppReducer = Reducer<AppState, AppAction, AppEnvironment>

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
    var lock: LockState
    var search: SearchState
    var toolbar: ToolbarState

    var settings: SettingsState {
        get {
            .init(
                toolbarPosition: toolbar.toolbarPosition.settingsPosition
            )
        }
        set {
            toolbar.toolbarPosition = .init(newValue.toolbarPosition)
        }
    }
}

public enum AppAction: BindableAction {
    case binding(BindingAction<AppState>)
    case lifecycle(LifecycleAction)
    case lock(LockAction)
    case welcome(WelcomeAction)
    case search(SearchAction)
    case toolbar(ToolbarAction)
    case settings(SettingsAction)
}

public struct AppEnvironment {
    let defaults: Defaults
}

public let appReducerCore = AppReducer { state, action, environment in
    switch action {
    case .binding: return .none
    case .lifecycle: return .none
    case .lock: return .none
    case .toolbar(.settingsTapped):
        state.showSettings = true
        return .none
    case .toolbar: return .none
    case .settings: return .none
    case .welcome(.startBrowsing):
        environment.defaults.userHasSeenOnboarding(true)
        state.shouldShowOnboarding = false
        return .none
    }
}.binding()

public let appReducer = Reducer.combine(
    appReducerCore,
    appLifecycleReducer.pullback(
        state: \.lifecycle,
        action: /AppAction.lifecycle,
        environment: { $0 }
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
        environment: \.toolbar)
)

extension AppStore {
    public static var live: AppStore {
        .init(
            initialState: .initial,
            reducer: appReducer.debug(),
            environment: .live
        )
    }

    public var lifecycle: LifecycleStore {
        scope(state: \.lifecycle, action: AppAction.lifecycle)
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

extension AppState {
    static var initial: AppState {
        .init(
            shouldShowOnboarding: false,
            showSettings: false,
            lock: .initial,
            search: .initial,
            toolbar: .initial
        )
    }
}

extension AppEnvironment {
    static var live: AppEnvironment {
        .init(
            defaults: .live
        )
    }

    var toolbar: ToolbarEnvironment {
        .init()
    }
}

extension AppState {
    var lifecycle: LifecycleState {
        get {
            .init(shouldShowOnboarding: shouldShowOnboarding)
        }
        set {
            shouldShowOnboarding = newValue.shouldShowOnboarding
        }
    }
}
