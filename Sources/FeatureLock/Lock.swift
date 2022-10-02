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
        case locked, unlocked, canceled, unlockFailed
    }

    public var isEnabled: Bool
    public var biometricType: BiometricType
    public var status: Status
    
}

public enum LockAction {
    case attemptLock
    case authenticate
    case authenticationSuccess
    case authenticationFailed
    case authenticationCancelled
}

public struct LockEnvironment {
    public var biometrics: Biometrics

    public init(
        biometrics: Biometrics
    ) {
        self.biometrics = biometrics
    }
}

public let lockReducer = LockReducer { state, action, env in
    switch action {
    case .attemptLock:
        if state.isEnabled {
            state.status = .locked
        }

        return .none
    case .authenticate:
        guard state.isEnabled && state.status == .locked else { return .none }
        return .task {
            let result = try await env.biometrics.authenticate()
            return .authenticationSuccess
        } catch: { _ in return .authenticationFailed }
    case .authenticationFailed:
        state.status = .unlockFailed
        return .none
    case .authenticationCancelled: return .none
    case .authenticationSuccess:
        state.status = .unlocked
        return .none
    }
}

public extension LockState {
    static var initial: LockState {
        .init(isEnabled: false, biometricType: .none, status: .unlocked)
    }

    static var testDisabled: LockState {
        .init(isEnabled: false, biometricType: .faceID, status: .unlocked)
    }

    static var testEnabledAndLocked: LockState {
        .init(isEnabled: true, biometricType: .touchID, status: .locked)
    }
}

extension LockStore {
    static var initial: LockStore {
        .init(initialState: .initial, reducer: .empty, environment: ())
    }
}
