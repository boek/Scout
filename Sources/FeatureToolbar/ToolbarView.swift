//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import ComposableArchitecture
import SwiftUI

public struct ToolbarView: View {
    let store: ToolbarStore

    public init(store: ToolbarStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            TextField("Query", text: viewStore.binding(\.$query), axis: .vertical)
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView(store: .init(initialState: .initial, reducer: .empty, environment: ()))
    }
}
