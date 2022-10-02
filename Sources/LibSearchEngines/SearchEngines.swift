//
//  File.swift
//  
//
//  Created by Jeff Boek on 9/8/22.
//

import Foundation

public struct SearchEngines {
    public var load: () async throws -> [SearchEngine]

    public init(
        load: @escaping () async throws -> [SearchEngine]
    ) {
        self.load = load
    }
}

public extension SearchEngines {
    static var test: SearchEngines {
        .init(
            load: { [.test] }
        )
    }
}
