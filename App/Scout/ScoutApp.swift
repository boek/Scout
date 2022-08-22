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
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        BrowserScene(store: appDelegate.store)
    }
}
