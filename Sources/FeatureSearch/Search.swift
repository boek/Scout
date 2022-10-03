//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/25/22.
//

import ComposableArchitecture

import LibSearchEngines
import LibSearchSuggestions

public typealias SearchStore = Store<SearchState, SearchAction>
public typealias SearchReducer = Reducer<SearchState, SearchAction, SearchEnvironment>

public enum SearchSuggestionState: Codable {
    case pending, allowed, denied
}

public struct SearchState: Equatable {
    public var anchorToBottom: Bool
    public var searchSuggestionState: SearchSuggestionState
    public var query: String
    public var searchSuggestions: SearchSuggestions?
    public var selectedSearchEngine: SearchEngine?
    public var searchEngines: [SearchEngine]

    public init(
        anchorToBottom: Bool,
        searchSuggestionState: SearchSuggestionState,
        query: String,
        searchSuggestions: SearchSuggestions?,
        selectedSearchEngine: SearchEngine?,
        searchEngines: [SearchEngine]
    ) {
        self.anchorToBottom = anchorToBottom
        self.searchSuggestionState = searchSuggestionState
        self.query = query
        self.searchSuggestions = nil
        self.selectedSearchEngine = selectedSearchEngine
        self.searchEngines = searchEngines
    }
}

public enum SearchAction: Equatable {
    case allowSearchSuggestions
    case denySearchSuggestions
    case perform(String)
    case suggestionResult(SearchSuggestions)
}

public struct SearchEnvironment {
    public var searchSuggestionsClient: SearchSuggestionsClient

    public init(
        searchSuggestionsClient: SearchSuggestionsClient
    ) {
        self.searchSuggestionsClient = searchSuggestionsClient
    }
}

public extension SearchEnvironment {
    static var test: SearchEnvironment {
        .init(
            searchSuggestionsClient: .test
        )
    }
}

public let searchReducer = SearchReducer { state, action, environment in
    switch action {
    case .denySearchSuggestions:
        state.searchSuggestionState = .denied
        return .none
    case .allowSearchSuggestions:
        state.searchSuggestionState = .allowed
        return .none
    case .suggestionResult(let suggestions):
        state.searchSuggestions = suggestions
        return .none
    case .perform(let query):
        state.query = query
        guard
            state.searchSuggestionState == .allowed,
            let engine = state.selectedSearchEngine
        else { return .none }

        return .task {
            let suggestions = try await environment.searchSuggestionsClient.query(engine, query)
            return .suggestionResult(suggestions)
        }
    }
}

public extension SearchState {
    static var initial: SearchState {
        .init(
            anchorToBottom: false,
            searchSuggestionState: .pending,
            query: "",
            searchSuggestions: nil,
            selectedSearchEngine: nil,
            searchEngines: []
        )
    }
}
