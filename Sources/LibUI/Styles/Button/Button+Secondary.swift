//
//  SwiftUIView.swift
//
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

public struct SecondaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        SecondaryButtonView(configuration: configuration)
    }

    struct SecondaryButtonView: View {
        @Environment(\.theme) var theme

        let configuration: Configuration

        var body: some View {
            configuration.label
                .bold()
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke()
                )
                .foregroundColor(theme.primary)
        }
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle { SecondaryButtonStyle() }
}


struct ButtonSecondary_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("hello")
        }.buttonStyle(.secondary)

        Button(action: {}) {
            Text("hello")
        }
        .buttonStyle(.secondary)

    }
}
