//
//  LockTests.swift
//  
//
//  Created by Jeff Boek on 10/1/22.
//

import XCTest
import ComposableArchitecture
import FeatureLock

@MainActor
final class LockTests: XCTestCase {
    func testNoopWhenNotEnabled() async {
        let store = TestStore(
            initialState: LockState.testEnabledAndLocked,
            reducer: lockReducer,
            environment: .init(biometrics: .test)
        )
    }

    func testCanUnlockWithAuthorizedBiometrics() async {
        let store = TestStore(
            initialState: LockState.testEnabledAndLocked,
            reducer: lockReducer,
            environment: .init(biometrics: .test)
        )

        await store.send(.authenticate)
        await store.receive(.authenticationSuccess) {
            $0.status = .unlocked
        }
    }
}
