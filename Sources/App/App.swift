//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture

import LibBiometrics
import LibDefaults
import LibEngine
import LibSearch

import FeatureBrowser
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

public enum AppAction: BindableAction {
    case binding(BindingAction<AppState>)
    case lifecycle(LifecycleAction)
    case browser(BrowserAction)
    case lock(LockAction)
    case welcome(WelcomeAction)
    case search(SearchAction)
    case toolbar(ToolbarAction)
    case settings(SettingsAction)
}

public struct AppEnvironment {
    let biometrics: Biometrics
    let defaults: Defaults
    let engine: Engine
}

public let appReducerCore = AppReducer { state, action, environment in
    switch action {
    case .binding: return .none
    case .lifecycle(.active): return .none
    case .lifecycle(.inactive):
        return .run { send in
            await send (.lock(.lock))
        }
    case .lifecycle: return .none
    case .browser: return .none
    case .lock: return .none
    case .toolbar(.onSubmit):
        var url = state.toolbar.query.asURL //?? state.searchEngine?.queryUrl(query)
        if let url = url {
            let request = URLRequest(url: url)
            environment.engine.dispatch(.load(request))
        }
        return .none
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

    var lifecycle: LifecycleStore {
        scope(state: \.lifecycle, action: AppAction.lifecycle)
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

extension AppState {
    static var initial: AppState {
        .init(
            shouldShowOnboarding: false,
            showSettings: false,
            browser: .inert,
            lock: .initial,
            search: .initial,
            toolbar: .initial
        )
    }
}

extension AppEnvironment {
    static var live: AppEnvironment {
        .init(
            biometrics: .live,
            defaults: .live,
            engine: .system
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
