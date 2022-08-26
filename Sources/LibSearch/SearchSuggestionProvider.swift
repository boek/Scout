//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/24/22.
//

import Foundation

public struct SearchSuggestionProvider {
    public var suggestions: (String) async -> [String]

    public init(
        suggestions: @escaping (String) async -> [String]
    ) {
        self.suggestions = suggestions
    }
}

public extension SearchSuggestionProvider {
    static var testEmpty: SearchSuggestionProvider {
        .init(
            suggestions: { _ in [] }
        )
    }

    static var testEcho: SearchSuggestionProvider {
        .init(
            suggestions: { ["\($0) one", "\($0) two", "\($0) three"] }
        )
    }

    static var live: SearchSuggestionProvider {
        .init(
            suggestions: { query in
                []
            }
        )
    }
}
