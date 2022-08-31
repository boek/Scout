//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import ComposableArchitecture
import SwiftUI
import LibUI

extension ToolbarPosition {
    var paddingEdge: Edge.Set {
        switch self {
        case .top: return .bottom
        case .bottom: return .top
        }
    }
}

public struct ToolbarView: View {
    @Environment(\.horizontalSizeClass) var hsc
    let store: ToolbarStore

    public init(store: ToolbarStore) {
        self.store = store
    }

    public var body: some View {

            switch hsc {
            case .regular: regularView
            case .compact: compactView
            default: compactView
            }
    }

    @ViewBuilder var compactView: some View {
        WithViewStore(store) { viewStore in
            URLBar(store: store)
                .onAppear { viewStore.send(.onAppear) }
                .padding(.horizontal)
                .padding(viewStore.toolbarPosition.paddingEdge, 8)
        }
    }

    @ViewBuilder var regularView: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button(action: { }) {
                    Image(systemName: "chevron.left")
                }.padding(10)

                Button(action: { }) {
                    Image(systemName: "chevron.right")
                }.padding(10)

                URLBar(store: store)
                    .padding(.horizontal, 110)

                Button(action: { }) {
                    Image(systemName: "trash")
                }.padding(10)

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
                }.padding(10)
            }
            .onAppear { viewStore.send(.onAppear) }
            .padding(.horizontal)
            .padding(viewStore.toolbarPosition.paddingEdge, 8)
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .edgesIgnoringSafeArea(.all)
            .safeAreaInset(edge: .top) {
                ToolbarView(store: .preview)
            }

        BackgroundView()
            .edgesIgnoringSafeArea(.all)
            .safeAreaInset(edge: .bottom) {
                ToolbarView(store: .preview)
            }
    }
}
