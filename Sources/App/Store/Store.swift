//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture

typealias AppStore   = Store<AppState, AppAction>
typealias AppReducer = Reducer<AppState, AppAction, AppEnvironment>

struct AppState {

}

enum AppAction {
    case appDelegate(AppDelegateAction)
}

struct AppEnvironment {

}

let appReducer = AppReducer { state, action, environment in
    return .none
}




extension AppStore {
    static var live: AppStore {
        .init(
            initialState: .initial,
            reducer: appReducer.debugActions(),
            environment: .live)
    }
}

extension AppState {
    static var initial: AppState {
        .init()
    }
}

extension AppEnvironment {
    static var live: AppEnvironment {
        .init()
    }
}
