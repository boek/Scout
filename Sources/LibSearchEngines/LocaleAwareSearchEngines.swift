//
//  File.swift
//  
//
//  Created by Jeff Boek on 9/8/22.
//

import Foundation

fileprivate struct SearchEngineLookup: Codable {
    private let lookup: [String : [String]]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.lookup = try container.decode([String : [String]].self)
    }

    func callAsFunction(_ locale: String) -> [String]? {
        return lookup[locale]
    }
}

public extension SearchEngines {
    static func localeAware(locale: String = Locale.preferredLanguages.first!) -> SearchEngines {
        print(locale, Locale.preferredLanguages)
        return .init(
            load: {
                let components = locale
                    .components(separatedBy: "-")
                    .prefix(2)

                let searchPaths = [components.joined(separator: "-"), components[0], "default"]

                let engines = Bundle.module.url(forResource: "SearchEngines", withExtension: "plist")
                let data = try Data(contentsOf: engines!)
                let decoder = PropertyListDecoder()
                let lookup = try decoder.decode(SearchEngineLookup.self, from: data)
                print(lookup(searchPaths[0]))

                return []
            }
        )
    }
}
