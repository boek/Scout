//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

public extension View {
    func with(palette: Palette) -> some View {
        environment(\.palette, palette)
    }
}
