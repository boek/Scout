//
//  ContentBlockerTests.swift
//  
//
//  Created by Jeff Boek on 9/14/22.
//

import XCTest
import LibContentBlocker

final class ContentBlockerTests: XCTestCase {
    func testThatItCanLoadABlockList() throws {
        let rules = try BlockList.social.load()
        print(rules)
    }
}
