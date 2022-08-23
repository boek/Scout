//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import SwiftUI
import ComposableArchitecture

import LibUI

import FeatureHome
import FeatureSettings
import FeatureToolbar
import FeatureWelcome

extension FeatureToolbar.ToolbarPosition {
    var edge: VerticalEdge {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}

public struct AppView: View {
    let store: AppStore

    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                BackgroundView().edgesIgnoringSafeArea(.all)
                HomeView()

            }
            .safeAreaInset(edge: viewStore.toolbar.toolbarPosition.edge) {
                ToolbarView(store: store.toolbar)
                    .padding()
            }
            .sheet(isPresented: viewStore.binding(\.$shouldShowOnboarding)) {
                WelcomeView(store: store.welcome)
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: viewStore.binding(\.$showSettings)) {
                SettingsView(store: store.settings)
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: .init(initialState: .initial, reducer: .empty, environment: ()))
    }
}
