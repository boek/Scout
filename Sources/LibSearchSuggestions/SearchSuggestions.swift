//
//  File.swift
//  
//
//  Created by Jeff Boek on 9/7/22.
//

import LibSearchEngines
import Foundation

public typealias Query = String
public struct NoSuggestionProvider: Error {}
public struct BadURLError: Error {}

public struct SearchSuggestion: Codable, Equatable {
    public var suggestion: String

    public init(
        suggestion: String
    ) {
        self.suggestion = suggestion
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.suggestion = try container.decode(String.self)
    }
}

public struct SearchSuggestions: Codable, Equatable {
    public var query: Query
    public var results: [SearchSuggestion]

    public init(
        query: Query,
        results: [SearchSuggestion]
    ) {
        self.query = query
        self.results = results
    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.query = try container.decode(String.self)
        self.results = try container.decode([SearchSuggestion].self)
    }
}

public struct SearchSuggestionsClient {
    public var query: (SearchEngine, Query) async throws -> SearchSuggestions

    public init(
        query: @escaping (SearchEngine, Query) async throws -> SearchSuggestions
    ) {
        self.query = query
    }
}

public extension SearchSuggestionsClient {
    static var live: Self {
        .init(
            query: { searchEngine, query in
                guard let template = searchEngine.suggestTemplate else { throw NoSuggestionProvider() }
                guard let url = SearchEngineURLProvider(template)(query) else { throw BadURLError() }

                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                return try decoder.decode(SearchSuggestions.self, from: data)
            }
        )
    }

    static var test: Self {
        .init(
            query: { engine, query in
                return SearchSuggestions(query: query, results: [])
            }
        )
    }
}
