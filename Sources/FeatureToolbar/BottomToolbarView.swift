//
//  BottomToolbarView.swift
//  
//
//  Created by Jeff Boek on 8/30/22.
//

import ComposableArchitecture
import SwiftUI
import LibUI

public struct BottomToolbarView: View {
    @Environment(\.theme) var theme

    let store: ToolbarStore

    public init(store: ToolbarStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Button(action: {}) {
                    Image(systemName: "chevron.right")
                }

                Spacer()

                Button(action: {}) {
                    Image(systemName: "trash")
                }

                Spacer()

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
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 32)
            .background(BackgroundView().edgesIgnoringSafeArea(.all))
            .tint(theme.onBackground)
        }
    }
}

struct BottomToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbarView(store: .preview)
    }
}
