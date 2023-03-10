//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI
import ComposableArchitecture

public typealias ToolbarStore   = Store<ToolbarState, ToolbarAction>
public typealias ToolbarReducer = Reducer<ToolbarState, ToolbarAction, ToolbarEnvironment>

public enum ToolbarPosition {
    case top, bottom
}

public struct ToolbarState: Equatable {
    public var isCollapsed: Bool
    public var backgroundColor: Color
    @BindableState public var query: String
    @BindableState public var urlBarFocused: Bool
    public var autocompletion: String?
    public var toolbarPosition: ToolbarPosition
    public var progress: Double?
}

public extension ToolbarState {
    static var initial: ToolbarState {
        .init(
            isCollapsed: false,
            backgroundColor: .clear,
            query: "",
            urlBarFocused: false,
            autocompletion: nil,
            toolbarPosition: .top,
            progress: nil
        )
    }
}

public enum ToolbarAction: BindableAction, Equatable {
    case binding(BindingAction<ToolbarState>)
    case onAppear
    case onSubmit
    case trashTapped
    case clearTapped
    case reloadTapped
    case shieldTapped
    case helpTapped
    case settingsTapped
    case closeTapped
}

public struct ToolbarEnvironment {
    public init() { }
}

public let toolbarReducer = ToolbarReducer { state, action, environment in
    switch action {
    case .binding: return .none
    case .onAppear:
        state.urlBarFocused = true
        return .none
    case .onSubmit:
        return .none
    case .clearTapped:
        state.query = ""
        return .none
    case .reloadTapped:
        return .none
    case .trashTapped:
        return .none
    case .shieldTapped:
        return .none
    case .helpTapped:
        return .none
    case .settingsTapped:
        return .none
    case .closeTapped:
        state.urlBarFocused = false
        return .none
    }
}.binding()

extension ToolbarStore {
    static var preview: ToolbarStore {
        ToolbarStore(initialState: .initial, reducer: .empty, environment: ())
    }
}
