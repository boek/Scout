//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/25/22.
//

import ComposableArchitecture
import LibBiometrics

public typealias LockStore = Store<LockState, LockAction>
public typealias LockReducer = Reducer<LockState, LockAction, LockEnvironment>

public struct LockState: Equatable {
    public enum Status {
        case locked, unlocked, canceled
    }

    public var isEnabled: Bool
    public var biometricType: BiometricType
    public var status: Status
}

public enum LockAction {
    case attemptUnlock, lock, cancel, unlocked
}

public struct LockEnvironment {
    public var biometrics: Biometrics
}

public let lockReducer = LockReducer { state, action, env in
    return .none
}

public extension LockState {
    static var initial: LockState {
        .init(isEnabled: false, biometricType: .none, status: .unlocked)
    }
}

extension LockStore {
    static var initial: LockStore {
        .init(initialState: .initial, reducer: .empty, environment: ())
    }
}
