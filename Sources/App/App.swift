//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture

import LibDefaults

import FeatureToolbar
import FeatureWelcome

public typealias AppStore   = Store<AppState, AppAction>
public typealias AppReducer = Reducer<AppState, AppAction, AppEnvironment>

public struct AppState: Equatable {
    @BindableState var shouldShowOnboarding: Bool
    @BindableState var showSettings: Bool
    var toolbar: ToolbarState
}

public enum AppAction: BindableAction {
    case binding(BindingAction<AppState>)
    case appDelegate(AppDelegateAction)
    case welcome(WelcomeAction)
    case toolbar(ToolbarAction)
}

public struct AppEnvironment {
    let defaults: Defaults
}

public let appReducerCore = AppReducer { state, action, environment in
    switch action {
    case .binding: return .none
    case .appDelegate: return .none
    case .toolbar(.settingsTapped):
        state.showSettings = true
        return .none
    case .toolbar: return .none
    case .welcome(.startBrowsing):
        environment.defaults.userHasSeenOnboarding(true)
        state.shouldShowOnboarding = false
        return .none
    }
}.binding()

public let appReducer = Reducer.combine(
    appReducerCore,
    appDelegateReducer.pullback(
        state: \.appDelegateState,
        action: /AppAction.appDelegate,
        environment: { $0 }
    ),
    toolbarReducer.pullback(
        state: \.toolbar,
        action: /AppAction.toolbar,
        environment: \.toolbar)
)

extension AppStore {
    static var live: AppStore {
        .init(
            initialState: .initial,
            reducer: appReducer.debug(),
            environment: .live)
    }

    var welcome: WelcomeStore {
        scope(state: { _ in () }, action: AppAction.welcome)
    }

    var toolbar: ToolbarStore {
        scope(state: \.toolbar, action: AppAction.toolbar)
    }
}

extension AppState {
    static var initial: AppState {
        .init(
            shouldShowOnboarding: false,
            showSettings: false,
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
    var appDelegateState: AppDelegateState {
        get {
            AppDelegateState(shouldShowOnboarding: shouldShowOnboarding)
        }
        set {
            shouldShowOnboarding = newValue.shouldShowOnboarding
        }
    }
}
