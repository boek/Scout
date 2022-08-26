//
//  ScoutApp.swift
//  Scout
//
//  Created by Jeff Boek on 8/21/22.
//

import SwiftUI
import ComposableArchitecture
import App

@main
struct ScoutApp: App {
    let store: AppStore = AppStore.live
    @ObservedObject var viewStore: ViewStore<Void, LifecycleAction>

    init() {
        self.viewStore = ViewStore(store.lifecycle.stateless)
        viewStore.send(.initialize)
    }

    var body: some Scene {
        BrowserScene(store: store)
    }
}
