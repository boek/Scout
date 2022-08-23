//
//  HomeView.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI
import LibUI

public struct HomeView: View {
    public init() {}

    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "shield")
                Text("0 trackers blocked so far")
                Button(action: {}) {
                    Text("Share")
                }.buttonStyle(.secondary)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
