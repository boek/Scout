//
//  File.swift
//
//
//  Created by Jeff Boek on 5/27/22.
//

import ComposableArchitecture
import SwiftUI
import LibEngine

public struct BrowserView: View {
    let store: BrowserStore

    public init(store: BrowserStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            switch viewStore.state {
            case.inert:
                Color.clear
                    .onAppear { viewStore.send(.start) }
            case .loaded(let engineViewFactory): WebView(engineViewFactory: engineViewFactory)
            }
        }
    }
}
