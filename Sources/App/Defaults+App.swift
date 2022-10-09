//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import Foundation

import FeatureSearch

import LibDefaults

extension Defaults {
    private static let userHasSeenOnboardingKey = "userHasSeenOnboardingKey"
    private static let shouldLockKey = "shouldLockKey"
    private static let searchSuggestionsKey = "searchSuggestionsKey"
    private static let launchCountKey = "launchCountKey"
    private static let launchThreshold = "launchThresholdKey"
    private static let lastReviewDateKey = "lastReviewDateKey"

    var lastReviewDate: Date? {
        guard let data = data(Self.lastReviewDateKey) else { return nil }
        return try? JSONDecoder().decode(Date.self, from: data)
    }
    func setLastReviewDate(_ date: Date) {
        guard let data = try? JSONEncoder().encode(date) else { return }
        setData(data, Self.searchSuggestionsKey)
    }

    var launchThreshold: Int { int(Self.launchThreshold) }
    func setLaunchThreshold(_ threshold: Int) {
        setInt(threshold, Self.launchThreshold)
    }

    var launchCount: Int {
        int(Self.launchCountKey)
    }

    func increaseLaunchCount(by: Int) {
        setInt(launchCount + by, Self.launchCountKey)
    }

    var searchSuggestionState: SearchSuggestionState {
        data(Self.searchSuggestionsKey)
            .flatMap { try? JSONDecoder().decode(SearchSuggestionState.self, from: $0) } ?? .pending
    }
    func searchSuggestionState(_ state: SearchSuggestionState) {
        guard let data = try? JSONEncoder().encode(state) else { return }
        setData(data, Self.searchSuggestionsKey)
    }


    var userHasSeenOnboarding: Bool { self.bool(Self.userHasSeenOnboardingKey) }
    func userHasSeenOnboarding(_ bool: Bool) { self.setBool(bool, Self.userHasSeenOnboardingKey) }

    var shouldLock: Bool { self.bool(Self.shouldLockKey) }
    func shouldLock(_ bool: Bool) { self.setBool(bool, Self.shouldLockKey) }
}
