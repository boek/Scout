//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import SwiftUI
import ComposableArchitecture

import FeatureHome
import FeatureToolbar
import FeatureWelcome

public struct AppView: View {
    let store: AppStore

    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                HomeView()

            }
            .safeAreaInset(edge: .bottom) { ToolbarView(store: store.toolbar) }
            .sheet(isPresented: viewStore.binding(\.$shouldShowOnboarding)) {
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
