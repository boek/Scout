//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture

public typealias LifecycleStore = Store<(LifecycleState), LifecycleAction>
typealias LifecycleReducer = Reducer<LifecycleState, LifecycleAction, AppEnvironment>

public struct LifecycleState: Equatable {
    public var shouldShowOnboarding: Bool
}

public enum LifecycleAction {
    case initialize
}

let appLifecycleReducer = LifecycleReducer { state, action, env in
    switch action {
    case .initialize:
        state.shouldShowOnboarding = !env.defaults.userHasSeenOnboarding
        return .none
    }
}
