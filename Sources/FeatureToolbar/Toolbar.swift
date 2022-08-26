//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import ComposableArchitecture

public typealias ToolbarStore   = Store<ToolbarState, ToolbarAction>
public typealias ToolbarReducer = Reducer<ToolbarState, ToolbarAction, ToolbarEnvironment>

public enum ToolbarPosition {
    case top, bottom
}

public struct ToolbarState: Equatable {
    @BindableState public var query: String
    @BindableState public var urlBarFocused: Bool
    @BindableState public var showMenu: Bool
    public var autocompletion: String?
    public var toolbarPosition: ToolbarPosition
}

public extension ToolbarState {
    static var initial: ToolbarState {
        .init(
            query: "",
            urlBarFocused: false,
            showMenu: true,
            autocompletion: nil,
            toolbarPosition: .top
        )
    }
}

public enum ToolbarAction: BindableAction {
    case binding(BindingAction<ToolbarState>)
    case onAppear
    case onSubmit
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
