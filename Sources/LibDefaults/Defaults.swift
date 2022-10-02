//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import Foundation

public typealias Key = String
public struct Defaults {
    public var bool: (Key) -> Bool
    public var setBool: (Bool, Key) -> Void
}

public extension Defaults {
    static var testAlwaysFalse: Defaults {
        Defaults(
            bool: { _ in false },
            setBool: { _, _ in }
        )
    }

    static func live(
        defaults: UserDefaults = .standard
    ) -> Defaults {
        return Defaults(
            bool: defaults.bool(forKey:),
            setBool: defaults.set
        )
    }
}
