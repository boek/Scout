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
    private static var userHasSeenOnboardingKey = "userHasSeenOnboardingKey"
    private static var shouldLockKey = "shouldLockKey"
    private static var searchSuggestionsKey = "searchSuggestionsKey"
    private static var launchCountKey = "launchCountKey"

    var launchCount: Int {
        int(Self.launchCountKey)
    }
    func increaseLaunchCount() {
        setInt(launchCount + 1, Self.launchCountKey)
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
