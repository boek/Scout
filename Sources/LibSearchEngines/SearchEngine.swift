//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/23/22.
//

import Foundation

public struct SearchEngineURLProvider: Equatable, Codable {
    public var template: String

    public init(_ template: String) {
        self.template = template
    }

    public func callAsFunction(_ query: String) -> URL? {
        let searchTermComponent = "{searchTerms}"
        let localeTermComponent = "{moz:locale}"

        return query
            .trimmingCharacters(in: .whitespaces)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryParameterAllowed)
            .map { template.replacingOccurrences(of: searchTermComponent, with: $0) }
            .map { $0.replacingOccurrences(of: localeTermComponent, with: Locale.current.identifier) }
            .flatMap { $0.addingPercentEncoding(withAllowedCharacters: .urlAllowed) }
            .flatMap(URL.init(string:))
    }
}

public struct SearchEngine: Equatable, Codable {
    public var name: String
    public var image: Data?
    public var queryTemplate: String
    public var suggestTemplate: String?
}

public extension SearchEngine {
    static var test: Self {
        .init(
            name: "Awesearch",
            image: nil,
            queryTemplate: "https://awesearch.com/?suggestions={searchTerm}",
            suggestTemplate: "https://awesearch.com/?q={searchTerm}"
        )
    }
}
