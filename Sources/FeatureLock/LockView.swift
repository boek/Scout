//
//  LockView.swift
//  
//
//  Created by Jeff Boek on 8/25/22.
//

import ComposableArchitecture
import SwiftUI
import LibUI

public struct LockView: View {
    let store: LockStore

    public init(store: LockStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            if viewStore.status == .locked {
                BackgroundView()
                    .onAppear { viewStore.send(.attemptUnlock) }
            }
        }
    }
}

struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView(store: .initial)
    }
}
