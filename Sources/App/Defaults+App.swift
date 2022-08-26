//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import Foundation
import LibDefaults

extension Defaults {
    private static var userHasSeenOnboardingKey = "userHasSeenOnboardingKey"
    private static var shouldLockKey = "shouldLockKey"

    var userHasSeenOnboarding: Bool { self.bool(Self.userHasSeenOnboardingKey) }
    func userHasSeenOnboarding(_ bool: Bool) { self.setBool(bool, Self.userHasSeenOnboardingKey) }

    var shouldLock: Bool { self.bool(Self.shouldLockKey) }
    func shouldLock(_ bool: Bool) { self.setBool(bool, Self.shouldLockKey) }
}
