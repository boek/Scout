//
//  AppTests.swift
//  
//
//  Created by Jeff Boek on 10/2/22.
//

import XCTest
import ComposableArchitecture
@testable import App

final class AppTests: XCTestCase {
    func testSearchEnginesAreInitializedOnAppStart() {
        let store = TestStore(
            initialState: AppState.initial,
            reducer: appReducer,
            environment: .test
        )
    }
}
