//
//  File.swift
//  
//
//  Created by Jeff Boek on 10/1/22.
//

import Foundation
import ComposableArchitecture

import LibSearchEngines

import FeatureBrowser
import FeatureLock
import FeatureWelcome
import FeatureSearch
import FeatureToolbar
import FeatureSettings

public enum LifecycleAction: Equatable {
    case initialize
    case active
    case inactive
    case background
}

public enum AppAction: BindableAction, Equatable {
    case binding(BindingAction<AppState>)
    case lifecycle(LifecycleAction)
    case browser(BrowserAction)
    case lock(LockAction)
    case welcome(WelcomeAction)
    case search(SearchAction)
    case toolbar(ToolbarAction)
    case settings(SettingsAction)
    case searchEnginesLoaded([SearchEngine])
}
