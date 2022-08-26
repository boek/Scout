//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        PrimaryButtonView(configuration: configuration)
    }

    struct PrimaryButtonView: View {
        @Environment(\.theme) var theme

        let configuration: Configuration

        var body: some View {
            configuration.label
                .bold()
                .padding(12)
                .background(configuration.isPressed ? theme.primaryVariant : theme.primary)
                .foregroundColor(theme.onPrimary)
                .cornerRadius(5)
        }
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}


struct ButtonPrimary_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("hello")
        }.buttonStyle(.primary)

        Button(action: {}) {
            Text("hello")
        }
        .buttonStyle(.primary)

    }
}
