//
//  File.swift
//  
//
//  Created by Jeff Boek on 10/2/22.
//

import SwiftUI

extension ScenePhase {
    var action: LifecycleAction {
        switch self {
        case .background: return .background
        case .inactive: return .inactive
        case .active: return .active
        @unknown default: fatalError()
        }
    }
}
