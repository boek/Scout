//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture
import UIKit

typealias AppViewStore = ViewStore<Void, AppDelegateAction>
typealias AppDelegateReducer = Reducer<AppDelegateState, AppDelegateAction, AppEnvironment>

struct AppDelegateState {
    var shouldShowOnboarding: Bool
}

public enum AppDelegateAction {
    case didFinishLaunching
}

let appDelegateReducer = AppDelegateReducer { state, action, environment in
    switch action {
    case .didFinishLaunching:
        state.shouldShowOnboarding = !environment.defaults.userHasSeenOnboarding
        return .none
    }
}


public class AppDelegate: NSObject, UIApplicationDelegate {
    public let store = AppStore.live
    private lazy var viewStore = ViewStore(store.stateless.scope(state: {}, action: AppAction.appDelegate))

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        viewStore.send(.didFinishLaunching)
        return true
    }
}
