//
//  SwiftUIView.swift
//  
//
//  Created by Jeff Boek on 9/21/22.
//

import SwiftUI

public struct ProgressView: View {
    let progress: Double
    @State private var animateGradient = false

    public init(progress: Double) {
        self.progress = progress
    }

    public var body: some View {
        GeometryReader { reader in
            RadialGradient(
                colors: [
                    .purple,
                    .pink,
                    .yellow
                ],
                center: .init(x: animateGradient ? 2 : -1, y: 0),
                startRadius: 0,
                endRadius: reader.size.width
            )
            .frame(width: reader.size.width * progress)
        }
        .frame(height: 1.5)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 1).repeatForever(autoreverses: true)
            ) {
                animateGradient.toggle()
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progress: 0.1)
        ProgressView(progress: 0.5)
        ProgressView(progress: 1.0)
    }
}
