//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/29/22.
//

import Foundation

import LibTelemetry

extension LifecycleAction {
    var event: TelemetryEvent? {
        let method: String?
        switch self {
        case .initialize: method = "launched"
        case .active: method = "foreground"
        case .inactive: method = nil
        case .background: method = "background"
        }

        return method.map { TelemetryEvent(category: "action", method: $0, object: "app", timestamp: .max, extras: [:]) }
    }
}

extension AppAction {
    var event: TelemetryEvent? {
        switch self {
        case .binding: return nil
        case .lifecycle(let lifecycleAction): return lifecycleAction.event
        case .browser: return nil
        case .lock: return nil
        case .welcome: return nil
        case .search: return nil
        case .toolbar: return nil
        case .settings: return nil
        case .searchEnginesLoaded: return nil
        }
    }
}

extension AppReducer {
    func telemetry() -> Self {
        Self { state, action, env in
            if let event = action.event {
                env.telemetry.track(event)
            }

            return self.run(&state, action, env)
        }
    }
}
