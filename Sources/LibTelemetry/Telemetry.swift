//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/29/22.
//

import Foundation

public struct TelemetryEvent {
    public var category: String
    public var method: String
    public var object: String
    public var value: String?
    public var timestamp: UInt64
    public var extras: [String : String]

    public init(
        category: String,
        method: String,
        object: String,
        value: String? = nil,
        timestamp: UInt64,
        extras: [String : String]
    ) {
        self.category = category
        self.method = method
        self.object = object
        self.value = value
        self.timestamp = timestamp
        self.extras = extras
    }
}

public struct Telemetry {
    public var track: (TelemetryEvent) -> Void
}

public extension Telemetry {
    static var live: Self {
        .init(track: { print("🪵", $0) })
    }
}
