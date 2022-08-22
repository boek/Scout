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

    var userHasSeenOnboarding: Bool { self.bool(Self.userHasSeenOnboardingKey) }
    func userHasSeenOnboarding(_ bool: Bool) { self.setBool(bool, Self.userHasSeenOnboardingKey) }
}
