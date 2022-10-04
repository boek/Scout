//
//  AppTests.swift
//  
//
//  Created by Jeff Boek on 10/2/22.
//

import XCTest
import ComposableArchitecture
@testable import App

@MainActor
final class AppTests: XCTestCase {
    func testInitializing() async {
        let store = TestStore(
            initialState: AppState.initial,
            reducer: appReducer,
            environment: .test
        )

        let setIntExpectation = expectation(description: "We set the launch count + 1")
        setIntExpectation.expectedFulfillmentCount = 1
        store.environment.defaults.setInt = { n, k in
            setIntExpectation.fulfill()
            XCTAssertEqual(n, 1)
        }

        let crashInitialzied = expectation(description: "LibCrash initialized")
        store.environment.crash.initialize = { _ in crashInitialzied.fulfill() }

        let experimentsInitialized = expectation(description: "LibExperiments initialized")
        store.environment.experiments.initialize = { experimentsInitialized.fulfill() }

        await store.send(.lifecycle(.initialize)) {
            $0.shouldShowOnboarding = true
        }

        await store.receive(.searchEnginesLoaded([.test])) {
            $0.search.selectedSearchEngine = .test
            $0.search.searchEngines = [.test]
        }

        waitForExpectations(timeout: 1)
    }
}
