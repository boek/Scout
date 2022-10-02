//
//  DefaultsTests.swift
//  
//
//  Created by Jeff Boek on 10/2/22.
//

import XCTest
import LibDefaults

final class DefaultsTests: XCTestCase {
    static let testDomain = "LibDefaults.tests"
    let defaults = UserDefaults(suiteName: DefaultsTests.testDomain)!

    override func tearDown() async throws {
        defaults.removePersistentDomain(forName: Self.testDomain)
    }

    func testThatItCanSaveAndRetreiveABool() {
        let key = Self.testDomain.appending(".bool")
        let defaults = Defaults.live(defaults: defaults)
        XCTAssertFalse(defaults.bool(key))
        defaults.setBool(true, key)
        XCTAssertTrue(defaults.bool(key))
    }
}
