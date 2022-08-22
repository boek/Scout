//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import SwiftUI
import ComposableArchitecture
import FeatureWelcome

public struct AppView: View {
    let store: AppStore

    public var body: some View {
        WithViewStore(store) { viewStore in
            Text(viewStore.shouldShowOnboarding ? "showing" : "seen")
                .sheet(isPresented: viewStore.binding(get: \.shouldShowOnboarding, send: {_ in .appDelegate(.didFinishLaunching)})) {
                    WelcomeView(store: store.welcome)
                        .interactiveDismissDisabled()
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: .init(initialState: .initial, reducer: .empty, environment: ()))
    }
}
