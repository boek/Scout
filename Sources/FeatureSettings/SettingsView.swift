//
//  SettingsView.swift
//  
//
//  Created by Jeff Boek on 8/23/22.
//

import ComposableArchitecture
import SwiftUI
import LibUI

public struct SettingsView: View {
    @Environment(\.theme) var theme
    @Environment(\.dismiss) var dismiss

    var store: SettingsStore

    public init(
        store: SettingsStore
    ) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationStack {
                List {
                    Section("General") {
                        NavigationLink(value: "foo") {
                            HStack {
                                Text("Theme")
                                Spacer()
                                Text("System Theme")
                            }
                        }

                        HStack {
                            Spacer()
                            VStack(spacing: 4) {
                                Image(systemName: "platter.filled.top.and.arrow.up.iphone")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 66)
                                Text("Top")
                                    .font(.caption)
                                Image(systemName: viewStore.toolbarPosition == .top ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 22)
                            }.onTapGesture {
                                viewStore.send(.set(\.$toolbarPosition, .top))
                            }
                            Spacer()
                            VStack(spacing: 4) {
                                Image(systemName: "platter.filled.bottom.and.arrow.down.iphone")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 66)
                                Text("Bottom")
                                    .font(.caption)
                                Image(systemName: viewStore.toolbarPosition == .bottom   ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 22)
                            }.onTapGesture {
                                viewStore.send(.set(\.$toolbarPosition, .bottom))
                            }
                            Spacer()
                        }
                    }

                    Section("Privacy") {
                        NavigationLink(value: "foo") {
                            HStack {
                                Text("Tracking Protection")
                                Spacer()
                                Text("On")
                            }
                        }
                        Toggle("Block Web fonts", isOn: .constant(true))
                        Toggle("Use Face ID to unlock app", isOn: .constant(true))
                    }

                    Section {
                        Toggle("Send usage data", isOn: .constant(true))
                    } footer: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Mozilla strives to collect only what we need to provide and improve Firefox Focus for everyone")
                            Text("Learn more.").foregroundColor(theme.primary)
                        }

                    }

                    Section {
                        Toggle("Studies", isOn: .constant(true))
                    } footer: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Firefox Focus may install and run studies from time to time.")
                            Text("Learn more.").foregroundColor(theme.primary)
                        }

                    }

                    Section {
                        NavigationLink(value: "foo") {
                            HStack {
                                Text("Search Engine")
                                Spacer()
                                Text("Google")
                            }
                        }
                        NavigationLink(value: "foo") {
                            HStack {
                                Text("URL Autocomplete")
                                Spacer()
                                Text("Enabled")
                            }
                        }
                        Toggle("Get Search Suggestions", isOn: .constant(true))
                    } header: { Text("Search") } footer: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Firefox Focus will send what you type in the address bar to your search engine.")
                            Text("Learn more.").foregroundColor(theme.primary)
                        }
                    }
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button(action: {}) {
                        Image(systemName: "gift.fill")
                    }
                    Button("Done", action: dismiss.callAsFunction)
                }.tint(theme.primary)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(store: .init(initialState: .initial, reducer: .empty, environment: ()))
    }
}
