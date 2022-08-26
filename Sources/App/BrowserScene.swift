//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture
import SwiftUI

public struct BrowserScene: Scene {
    let store: AppStore
    @ObservedObject var viewStore: ViewStore<Void, LifecycleAction>
    @Environment(\.scenePhase) private var scenePhase

    public init(store: AppStore) {
        self.store = store
        viewStore = ViewStore(store.lifecycle.stateless)
        viewStore.send(.initialize)
    }

    public var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active: viewStore.send(.active)
            case .inactive: viewStore.send(.inactive)
            case .background: viewStore.send(.background)
            @unknown default: fatalError()
            }
        }
    }
}
