//
//  SearchSuggestionsTests.swift
//  
//
//  Created by Jeff Boek on 9/7/22.
//

import XCTest
import LibSearchSuggestions

final class SearchSuggestionsTests: XCTestCase {
    func testCanParseResults() throws {
        let suggestionData = """
        ["query", ["First", "Second", "Third"]]
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let suggestions = try decoder.decode(SearchSuggestions.self, from: suggestionData)
        XCTAssertEqual(suggestions.query, "query")
        XCTAssertEqual(suggestions.results[2].suggestion, "Third")
    }
}
