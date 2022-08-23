//
//  BackgroundView.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

public struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.palette) var palette

    public init() { }

    public var body: some View {
        RadialGradient(
            gradient: gradient,
            center: .bottom,
            startRadius: 0,
            endRadius: 1000)
    }

    var gradient: Gradient {
        switch colorScheme {
        case .light:
            return .init(
                stops: [
                    .init(color: palette.violet.zeroFive, location: 0),
                    .init(color: palette.purple.zeroFive, location: 0.25),
                    .init(color: palette.violet.ten, location: 0.5),
                    .init(color: palette.violet.zeroFive, location: 0.8),
                    .init(color: palette.purple.zeroFive, location: 1.0),
                ])
        case .dark:
            return .init(
                stops: [
                    .init(color: palette.violet.ninety, location: 0),
                    .init(color: palette.violet.seventy, location: 0.5),
                    .init(color: palette.violet.ninety, location: 1.0),
                ])
        @unknown default: fatalError()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .edgesIgnoringSafeArea(.all)
    }
}
