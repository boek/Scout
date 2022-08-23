//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import ComposableArchitecture

public typealias ToolbarStore   = Store<ToolbarState, ToolbarAction>
public typealias ToolbarReducer = Reducer<ToolbarState, ToolbarAction, ToolbarEnvironment>

public struct ToolbarState: Equatable {
    @BindableState public var query: String
    @BindableState public var urlBarFocused: Bool
}

public extension ToolbarState {
    static var initial: ToolbarState {
        .init(
            query: "",
            urlBarFocused: false
        )
    }
}

public enum ToolbarAction: BindableAction {
    case binding(BindingAction<ToolbarState>)
    case onAppear
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
    }
}.binding()

extension ToolbarStore {
    static var preview: ToolbarStore {
        ToolbarStore(initialState: .initial, reducer: .empty, environment: ())
    }
}
