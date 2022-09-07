//
//  SearchSuggestionsTests.swift
//  
//
//  Created by Jeff Boek on 9/7/22.
//

import LibSearchSuggestions
import XCTest

final class SearchSuggestionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanParseResults() throws {
        let suggestionData = """
        ["query", ["First", "Second", "Third"]]
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let suggestions = try decoder.decode(SearchSuggestions.self, from: suggestionData)
        XCTAssertEqual(suggestions.query, "query")
        XCTAssertEqual(suggestions.results[2].suggestion, "Third")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
