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
                VStack(spacing: 16) {
                    Text("Show Search Suggestions?")
                        .font(.title2)
                        .bold()
                    Text("To get suggestions Firefox Focus needs to send what you type in the address bar to the search engine")
                        .font(.subheadline)

                    HStack {
                        Button("Yes") {}
                            .buttonStyle(.bordered)
                        Button("No") {}
                            .buttonStyle(.bordered)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .listRowBackground(Color.clear)
                .listRowSeparator(/*@START_MENU_TOKEN@*/.hidden/*@END_MENU_TOKEN@*/)
                .listRowInsets(.none)

                Section("Suggestions") {
                    Label("Hello", systemImage: "magnifyingglass")
                }
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
