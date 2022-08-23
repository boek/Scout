//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/23/22.
//

import ComposableArchitecture

typealias SettingsStore = Store<SettingsState, SettingsAction>

public enum ToolbarPosition {
    case top, bottom
}


public struct SettingsState {
    public var toolbarPosition: ToolbarPosition
}

enum SettingsAction {

}

public struct SettingsEnvironment {

}

public extension SettingsState {
    static var initial: SettingsState {
        .init(
            toolbarPosition: .top
        )
    }
}
