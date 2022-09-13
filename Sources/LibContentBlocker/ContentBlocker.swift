//
//  File.swift
//  
//
//  Created by Jeff Boek on 9/10/22.
//

import Foundation

public enum BlockList: String {
    case advertising
    case analytics
    case content
    case social

    public var filename: String { "disconnect-\(rawValue)" }

    static var all: [Self] { [.advertising, .analytics, .content, .social] }
    static var basic: [Self] { [.advertising, .analytics, .social] }
}
