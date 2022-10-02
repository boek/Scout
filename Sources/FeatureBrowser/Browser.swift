//
//  File.swift
//
//
//  Created by Jeff Boek on 5/26/22.
//

import ComposableArchitecture
import SwiftUI
import LibEngine

// MARK: Store

public typealias BrowserStore = Store<BrowserState, BrowserAction>
public extension BrowserStore {
    static var test: Self {
        .init(initialState: .test, reducer: browserReducer, environment: .test)
    }
}

public typealias BrowserViewStore = ViewStore<BrowserState, BrowserAction>
public typealias BrowserReducer = Reducer<BrowserState, BrowserAction, BrowserEnvironment>

// MARK: State

public enum BrowserState: Equatable {
    case inert
    case loaded(EngineViewFactory)
}

public extension BrowserState {
    static var test: Self { .inert }
}

// MARK: Action

public enum BrowserAction: Equatable {
    case start
    case engine(EngineEvent)
}

// MARK: Reducer
public let browserReducer = BrowserReducer { state, action, environment in
    switch action {
    case .start:
        state = .loaded(environment.engine.viewFactory)
        return .run { send in
            for await event in environment.engine.events.values {
                await send(.engine(event))
            }
        }
    case .engine(let event):
        print("Got event", event)
        return .none
    }
}

// MARK: Environment

public struct BrowserEnvironment {
    public var engine: Engine

    public init(
        engine: Engine
    ) {
        self.engine = engine
    }
}

public extension BrowserEnvironment {
    static var test: Self {
        .init(
            engine: .test
        )
    }
}
