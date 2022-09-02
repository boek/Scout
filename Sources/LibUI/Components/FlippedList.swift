//
//  FlippedList.swift
//  
//
//  Created by Jeff Boek on 9/1/22.
//

import SwiftUI

public struct FlippedList<Content: View>: View {
    var content: () -> Content

    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }

    public var body: some View {
        List {
            content()
                .rotationEffect(.radians(.pi))
                .scaleEffect(x: -1, y: 1, anchor: .center)
        }
        .rotationEffect(.radians(.pi))
        .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}

struct FlippedList_Previews: PreviewProvider {
    static var previews: some View {
        FlippedList {
            Section {
                Text("hello one")
            }
            Text("hello one")
            Text("hello one")
        }
    }
}
