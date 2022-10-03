//
//  SearchTests.swift
//  
//
//  Created by Jeff Boek on 10/2/22.
//

import XCTest
import ComposableArchitecture

import LibSearchSuggestions

import FeatureSearch


@MainActor
final class SearchTests: XCTestCase {
    func testCanPerformASearch() async {
        let store = TestStore(
            initialState: SearchState(
                anchorToBottom: true,
                searchSuggestionState: .allowed,
                query: "",
                searchSuggestions: nil,
                selectedSearchEngine: .test,
                searchEngines: [.test]
            ),
            reducer: searchReducer,
            environment: .test
        )

        let searchSuggestions = SearchSuggestions(
            query: "moz",
            results: [
                SearchSuggestion(suggestion: "mozilla")
            ])

        store.environment.searchSuggestionsClient.query = { _, _ in searchSuggestions }

        await store.send(.perform("mozilla")) {
            $0.query = "mozilla"
        }

        await store.receive(.suggestionResult(searchSuggestions)) {
            $0.searchSuggestions = searchSuggestion
        }
    }
}
