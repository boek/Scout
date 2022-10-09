//
//  File.swift
//  
//
//  Created by Jeff Boek on 10/3/22.
//

import Foundation
import UIKit
import StoreKit

extension UIScene {
    var isForeground: Bool { activationState == .foregroundActive }
}

public struct AppStore {
    public var requestReview: () -> Void
}

public extension AppStore {
    static var live: AppStore {
        return .init(
            requestReview: {
                guard let scene = UIApplication.shared.connectedScenes.first(where: \.isForeground) as? UIWindowScene
                else {
                    assertionFailure("Cannot find foregrounded scene")
                    return
                }

                SKStoreReviewController.requestReview(in: scene)
            }
        )
    }

    static var test: AppStore {
        .init(
            requestReview: {}
        )
    }
}
