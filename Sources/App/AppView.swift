//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import SwiftUI
import ComposableArchitecture

import LibUI

import FeatureBrowser
import FeatureHome
import FeatureLock
import FeatureSearch
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
                BrowserView(store: store.browser)
                if viewStore.toolbar.urlBarFocused && !viewStore.toolbar.query.isEmpty {
                    SearchView(store: store.search)
                        .background(Material.thin)
                }
            }
            .safeAreaInset(edge: viewStore.toolbar.toolbarPosition.edge) {
                ToolbarView(store: store.toolbar)
                    .padding(8)
            }
            .sheet(isPresented: viewStore.binding(\.$shouldShowOnboarding)) {
                WelcomeView(store: store.welcome)
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: viewStore.binding(\.$showSettings)) {
                SettingsView(store: store.settings)
            }
            .overlay(LockView(store: store.lock).edgesIgnoringSafeArea(.all))
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: .init(initialState: .initial, reducer: .empty, environment: ()))
    }
}
