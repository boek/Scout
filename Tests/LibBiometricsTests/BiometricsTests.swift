//
//  BiometricsTests.swift
//  
//
//  Created by Jeff Boek on 10/2/22.
//

import XCTest
import LibBiometrics
import LocalAuthentication

fileprivate class TestContext: LAContext {
    var canEvaluate = true
    var result = true

    override func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool {
        return canEvaluate
    }

    override func evaluatePolicy(_ policy: LAPolicy, localizedReason: String) async throws -> Bool {
        return result
    }
}

final class BiometricsTests: XCTestCase {
    func testThatItReturnsTrueWhenEnabled() {
        let context = TestContext()
        let biometrics = Biometrics.live(context: context)
        XCTAssertTrue(biometrics.isEnabled())
    }

    func testThatIsEnabledReturnsFalseWhenDisabled() {
        let context = TestContext()
        context.canEvaluate = false
        let biometrics = Biometrics.live(context: context)
        XCTAssertFalse(biometrics.isEnabled())
    }

    func testThatItReturnsTrueWhenAuthenticatingSuccessfully() async throws {
        let context = TestContext()
        let biometrics = Biometrics.live(context: context)
        let result = try await biometrics.authenticate()
        XCTAssertTrue(result)
    }

    func testThatItReturnsFalseWhenAuthenticatingFails() async throws {
        let context = TestContext()
        context.result = false
        let biometrics = Biometrics.live(context: context)
        let result = try await biometrics.authenticate()
        XCTAssertFalse(result)
    }
}
