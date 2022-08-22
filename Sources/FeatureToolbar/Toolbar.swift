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
}

public extension ToolbarState {
    static var initial: ToolbarState {
        .init(
            query: ""
        )
    }
}

public enum ToolbarAction: BindableAction {
    case binding(BindingAction<ToolbarState>)
}

public struct ToolbarEnvironment {
    public init() { }
}

public let toolbarReducer = ToolbarReducer { state, action, environment in
    return .none
}.binding()
