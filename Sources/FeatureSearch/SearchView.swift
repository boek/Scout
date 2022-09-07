//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/25/22.
//

import ComposableArchitecture
import SwiftUI
import LibUI

struct SearchList<Content: View>: View {
    let flipped: Bool
    @ViewBuilder var content: () -> Content

    var body: some View {
        if flipped {
            FlippedList { content() }
        } else {
            List { content() }
        }
    }
}

public struct SearchView: View {
    let store: SearchStore

    public init(store: SearchStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            SearchList(flipped: viewStore.anchorToBottom) {
                if viewStore.searchSuggestionState == .pending {
                    Section {
                        SearchSuggestionPrompt()
                            .listRowBackground(Color.clear)
                            .listRowSeparator(/*@START_MENU_TOKEN@*/.hidden/*@END_MENU_TOKEN@*/)
                            .listRowInsets(.none)
                    }
                }

                Section {
                    Button(action: {}) {
                        Label(viewStore.query, systemImage:
                                "magnifyingglass")
                        .id("searchResult")
                        .transition(.identity)
                    }
                }

//                if !viewStore.searchSuggestions.isEmpty {
//                    Section("Suggestions") {
//                        ForEach(viewStore.searchSuggestions) { suggestion in
//                            Label(suggestion, systemImage: "magnifyingglass")
//                        }
//                    }
//                }
            }
            .listRowInsets(.none)
            .scrollContentBackground(.hidden)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(store: .init(initialState: .initial, reducer: .empty, environment: ()))
            .background(Material.thin)
    }
}
