//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/25/22.
//

import ComposableArchitecture

public typealias SearchStore = Store<SearchState, SearchAction>
public typealias SearchReducer = Reducer<SearchState, SearchAction, SearchEnvironment>

public enum SearchSuggestionState {
    case pending, allowed, denied
}

public struct SearchState: Equatable {
    public var anchorToBottom: Bool
    public var searchSuggestionState: SearchSuggestionState
    public var query: String
    public var searchSuggestions: [String]
}

public enum SearchAction {
    case allowSearchSuggestions
    case denySearchSuggestions
}

public struct SearchEnvironment {

    public init() { }
}

public let searchReducer = SearchReducer { state, action, env in
    return .none
}

public extension SearchState {
    static var initial: SearchState {
        .init(
            anchorToBottom: false,
            searchSuggestionState: .pending,
            query: "",
            searchSuggestions: []
        )
    }
}
