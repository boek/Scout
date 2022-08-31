//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/30/22.
//

import Foundation

public struct Experiments {
    public var initialize: () -> Void

    public init(
        initialize: @escaping () -> Void
    ) {
        self.initialize = initialize
    }
}

public extension Experiments {
    static var live: Experiments {
        .init(
            initialize: { print("💥: Experiments initialized") }
        )
    }
}
