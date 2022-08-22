//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture
import UIKit

typealias AppViewStore = ViewStore<Void, AppDelegateAction>

enum AppDelegateAction {
    case didFinishLaunching
}


public class AppDelegate: NSObject, UIApplicationDelegate {
    let store = AppStore.live
    private lazy var viewStore = ViewStore(store.stateless.scope(state: {}, action: AppAction.appDelegate))


    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        viewStore.send(.didFinishLaunching)
        return true
    }
    public func applicationDidFinishLaunching(_ application: UIApplication) {
        viewStore.send(.didFinishLaunching)
    }
}
