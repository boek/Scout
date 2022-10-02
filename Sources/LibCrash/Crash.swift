//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/30/22.
//

import Foundation

public struct Crash {
    public var initialize: (String) -> Void

    public init(
        initialize: @escaping (String) -> Void
    ) {
        self.initialize = initialize
    }
}

public extension Crash {
    static var live: Crash {
        .init(
            initialize: { print("💥 Initializing crash reporter with key: \($0)") }
        )
    }

    static var test: Crash {
        .init(
            initialize: { print("💥 Initializing crash reporter with key: \($0)") }
        )
    }
}
