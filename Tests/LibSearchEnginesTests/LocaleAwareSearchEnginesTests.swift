//
//  LocaleAwareSearchEnginesTests.swift
//  
//
//  Created by Jeff Boek on 9/9/22.
//

import LibSearchEngines
import XCTest

final class LocaleAwareSearchEnginesTests: XCTestCase {

    func testExample() async throws {
        let engines = try await SearchEngines.localeAware().load()
        print(engines)
    }
}
