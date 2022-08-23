//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

public struct PaletteEnvironmentKey: EnvironmentKey {
    static public var defaultValue: Palette { .brand }
}

public extension EnvironmentValues {
    var palette: Palette {
        get { self[PaletteEnvironmentKey.self] }
        set { self[PaletteEnvironmentKey.self] = newValue }
    }
}
