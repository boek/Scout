//
//  File.swift
//  
//
//  Created by Jeff Boek on 9/10/22.
//

import Foundation
import SafariServices

public enum BlockList: String {
    case advertising
    case analytics
    case content
    case social
    case webFont

    public static var all: [Self] { [.advertising, .analytics, .content, .social] }
    public static var basic: [Self] { [.advertising, .analytics, .social] }

    public func load() throws -> [Rule] {
        guard let url = Bundle.module.url(forResource: "disconnect-\(rawValue)", withExtension: "json") else { return [] }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Rule].self, from: data)
    }
}

public struct Action: Codable {
    public var type: String
}

public struct Trigger: Codable {
    enum CodingKeys: String, CodingKey {
        case urlFilter = "url-filter"
        case resourceType = "resource-type"
        case loadType = "load-type"
        case unlessDomain = "unless-domain"
    }

    public var urlFilter: String
    public var resourceType: [String]?
    public var loadType: [String]?
    public var unlessDomain: [String]?
}

public struct Rule: Codable {
    public var action: Action
    public var trigger: Trigger
}

public struct ContentBlocker {
    public var combinedListURL: () throws -> URL
    public var createCombinedList: ([BlockList]) async -> URL
    public var reload: () async throws -> Void

    public init(
        combinedListURL: @escaping () throws -> URL,
        createCombinedList: @escaping ([BlockList]) async -> URL,
        reload: @escaping () async throws -> Void
    ) {
        self.combinedListURL = combinedListURL
        self.createCombinedList = createCombinedList
        self.reload = reload
    }
}

public struct InvalidURL: Error {}

public extension ContentBlocker {
    static var live: ContentBlocker {
        let combinedListFilePath = FileManager
            .default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.us.boek.scout")?
            .appending(path: "combined-lsit.json")

        return .init(
            combinedListURL: {
                guard let url = combinedListFilePath else { throw InvalidURL() }
                return url
            },
            createCombinedList: { blockLists in
                return combinedListFilePath!
            },
            reload: {
                try await withCheckedThrowingContinuation { continuation in
                    SFContentBlockerManager.reloadContentBlocker(withIdentifier: "us.boek.scout") { error in
                        if let error = error {
                            continuation.resume(throwing: error)
                            return
                        }
                        continuation.resume()
                    }
                }
            }
        )
    }
}
