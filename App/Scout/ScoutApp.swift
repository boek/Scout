//
//  ScoutApp.swift
//  Scout
//
//  Created by Jeff Boek on 8/21/22.
//

import SwiftUI
import App

@main
struct ScoutApp: App {
    let store: AppStore = AppStore.live

    var body: some Scene {
        BrowserScene(store: store)
    }
}
