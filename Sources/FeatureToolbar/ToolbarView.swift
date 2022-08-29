//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import ComposableArchitecture
import SwiftUI
import LibUI

public struct ToolbarView: View {
    let store: ToolbarStore

    public init(store: ToolbarStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            URLBar(store: store)
                .onAppear { viewStore.send(.onAppear) }
                .padding(.horizontal)
                .padding(.bottom, 8)
                .background(Material.thin)
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {

        BackgroundView()
            .edgesIgnoringSafeArea(.all)
            .overlay(ToolbarView(store: .preview).padding())

    }
}
