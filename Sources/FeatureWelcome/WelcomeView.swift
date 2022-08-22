//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import ComposableArchitecture
import SwiftUI

public struct WelcomeView: View {
    public let store: WelcomeStore

    public init(store: WelcomeStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { a in
            VStack {
                Text("Welcome to Scout!").font(.headline)
                Text("Take your browsing to the next level.").font(.subheadline)

                Label("More than just incognito", systemImage: "theatermasks")

                Label("More than just incognito", systemImage: "clock")

                Label("Protection at your own discretion", systemImage: "gearshape")

                Spacer()
                Button(action: { a.send(.startBrowsing) }) {
                    Text("Start browsing")
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(store: .init(initialState: (), reducer: .empty, environment: ()))
    }
}
