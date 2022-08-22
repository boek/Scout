//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture

import LibDefaults

import FeatureWelcome

public typealias AppStore   = Store<AppState, AppAction>
public typealias AppReducer = Reducer<AppState, AppAction, AppEnvironment>

public struct AppState: Equatable {
    @BindableState var shouldShowOnboarding: Bool
}

public enum AppAction: BindableAction {
    case binding(BindingAction<AppState>)
    case appDelegate(AppDelegateAction)
    case welcome(WelcomeAction)
}

public struct AppEnvironment {
    let defaults: Defaults
}

public let appReducerCore = AppReducer { state, action, environment in
    switch action {
    case .binding: return .none
    case .appDelegate: return .none
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
    )
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
}

extension AppState {
    static var initial: AppState {
        .init(
            shouldShowOnboarding: false
        )
    }
}

extension AppEnvironment {
    static var live: AppEnvironment {
        .init(
            defaults: .live
        )
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
