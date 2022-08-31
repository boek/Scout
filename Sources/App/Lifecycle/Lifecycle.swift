//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture

public typealias LifecycleStore = Store<(LifecycleState), LifecycleAction>
public typealias LifecycleReducer = Reducer<LifecycleState, LifecycleAction, AppEnvironment>

public struct LifecycleState: Equatable {
    public var shouldLock: Bool
    public var shouldShowOnboarding: Bool
}

public enum LifecycleAction {
    case initialize
    case active
    case inactive
    case background
}

public let lifecycleReducer = LifecycleReducer { state, action, env in
    switch action {
    case .initialize:
        env.crash.initialize("Key")
        env.experiments.initialize()
        state.shouldLock = env.biometrics.isEnabled() ? env.defaults.shouldLock : false
        state.shouldShowOnboarding = !env.defaults.userHasSeenOnboarding
        return .none
    case .active: return .none
    case .inactive: return .none
    case .background: return .none
    }
}
