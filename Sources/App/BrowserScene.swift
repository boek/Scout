//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/21/22.
//

import SwiftUI

public struct BrowserScene: Scene {
    let store: AppStore

    public init(store: AppStore) {
        self.store = store
    }

    public var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
