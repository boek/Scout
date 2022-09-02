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

                if viewStore.showBrowser {
                    BrowserView(store: store.browser)
                        .zIndex(1)
                }
                if viewStore.toolbar.urlBarFocused && !viewStore.toolbar.query.isEmpty {
                    SearchView(store: store.search)
                        .background(Material.bar)
                        .zIndex(2)
                }
            }
            .safeAreaInset(edge: viewStore.toolbar.toolbarPosition.edge, spacing: 0) {
                ToolbarView(store: store.toolbar)
            }
            .safeAreaInset(edge: .bottom) {
                if viewStore.showBrowser && !viewStore.toolbar.urlBarFocused {
                    BottomToolbarView(store: store.toolbar)
                }
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
