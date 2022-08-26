//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/23/22.
//

import ComposableArchitecture

public typealias SettingsStore = Store<SettingsState, SettingsAction>
public typealias SettingsReducer = Reducer<SettingsState, SettingsAction, SettingsEnvironment>

public enum ToolbarPosition {
    case top, bottom
}


public struct SettingsState: Equatable {
    @BindableState public var toolbarPosition: ToolbarPosition
    @BindableState public var lockEnabled: Bool

    public init(
        toolbarPosition: ToolbarPosition,
        lockEnabled: Bool
    ) {
        self.toolbarPosition = toolbarPosition
        self.lockEnabled = lockEnabled
    }
}

public enum SettingsAction: BindableAction {
    case binding(BindingAction<SettingsState>)
}

public struct SettingsEnvironment {
    public init() {}
}

public let settingsReducer = SettingsReducer { state, action, env in
    return .none
}.binding()

public extension SettingsState {
    static var initial: SettingsState {
        .init(
            toolbarPosition: .top,
            lockEnabled: false
        )
    }
}
