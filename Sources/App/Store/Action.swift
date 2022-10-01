//
//  File.swift
//  
//
//  Created by Jeff Boek on 10/1/22.
//

import Foundation
import ComposableArchitecture

import FeatureBrowser
import FeatureLock
import FeatureWelcome
import FeatureSearch
import FeatureToolbar
import FeatureSettings


public enum AppAction: BindableAction {
    case binding(BindingAction<AppState>)
    case lifecycle(LifecycleAction)
    case browser(BrowserAction)
    case lock(LockAction)
    case welcome(WelcomeAction)
    case search(SearchAction)
    case toolbar(ToolbarAction)
    case settings(SettingsAction)
}
