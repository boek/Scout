//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import ComposableArchitecture
import SwiftUI

import LibUI


struct URLBar: View {
    @Environment(\.theme) var theme
    let store: ToolbarStore
    @FocusState var addressFocusState: Bool

    var body: some View {
        WithViewStore(store) { viewStore in
            TextField(
                "Search or enter address",
                text: viewStore.binding(\.$query)
            )
                .autocapitalization(.none)
                .keyboardType(.webSearch)
                .focused($addressFocusState)
                .disableAutocorrection(true)
                .foregroundColor(theme.onBackground)
                .onSubmit { viewStore.send(.onSubmit) }
                .frame(height: 44)
                .safeAreaInset(edge: .leading) {
                    if !viewStore.urlBarFocused {
                        Button(action: { viewStore.send(.shieldTapped) }) {
                            Image(systemName: "shield")
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .safeAreaInset(edge: .trailing) {
                    if viewStore.urlBarFocused && viewStore.query.isEmpty {
                    } else if viewStore.urlBarFocused && !viewStore.query.isEmpty {
                        Button(action: { viewStore.send(.clearTapped, animation: .spring()) }) {
                            Image(systemName: "x.circle.fill")
                        }.transition(.scale.combined(with: .opacity))
                    } else if !viewStore.query.isEmpty {
                        Button(action: { viewStore.send(.reloadTapped) }) {
                            Image(systemName: "arrow.clockwise")
                        }.transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.horizontal, 5)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(theme.background)
                        .shadow(radius: 4)
                )
                .safeAreaInset(edge: .leading) {
                    if viewStore.urlBarFocused {
                        Button(action: { viewStore.send(.closeTapped, animation: .spring()) }) {
                            Image(systemName: "chevron.left")
                        }.transition(.scale.combined(with: .opacity))
                    }
                }
                .safeAreaInset(edge: .trailing) {
                    if viewStore.showMenu {
                        Menu {
                            Button(action: { viewStore.send(.helpTapped) }) {
                                Label("Help", systemImage: "questionmark.circle")
                            }
                            Divider()
                            Button(action: { viewStore.send(.settingsTapped) }) {
                                Label("Settings", systemImage: "gearshape.fill")
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }.transition(.scale.combined(with: .opacity))
                    }
                }
                .onChange(of: self.addressFocusState) { viewStore.send(.set(\.$urlBarFocused, $0), animation: .spring()) }
                .onChange(of: viewStore.urlBarFocused) { self.addressFocusState = $0 }
                .tint(theme.onBackground)
        }
    }
}
struct URLBar_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    URLBar(store: .preview)
                    URLBar(store: .preview)
                    URLBar(store: .preview)
                }.padding()
            )
    }
}
