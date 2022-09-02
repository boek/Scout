//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/25/22.
//

import ComposableArchitecture

public typealias SearchStore = Store<SearchState, SearchAction>
public typealias SearchReducer = Reducer<SearchState, SearchAction, SearchEnvironment>

public struct SearchState: Equatable {
    public var anchorToBottom: Bool
    public var searchSuggestionsEnabled: Bool
}

public enum SearchAction {

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
            searchSuggestionsEnabled: false
        )
    }
}
