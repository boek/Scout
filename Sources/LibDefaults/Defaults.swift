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
    public var data: (Key) -> Data?
    public var setData: (Data, Key) -> Void
    public var int: (Key) -> Int
    public var setInt: (Int, Key) -> Void
}

public extension Defaults {
    static var testAlwaysFalse: Defaults {
        Defaults(
            bool: { _ in false },
            setBool: { _, _ in },
            data: { _ in nil },
            setData: { _, _ in },
            int: { _ in 0 },
            setInt: { _, _ in }
        )
    }

    static func live(
        defaults: UserDefaults = .standard
    ) -> Defaults {
        return Defaults(
            bool: defaults.bool(forKey:),
            setBool: defaults.set,
            data: defaults.data(forKey:),
            setData: defaults.set,
            int: defaults.integer(forKey:),
            setInt: defaults.set
        )
    }
}
