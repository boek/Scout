//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

public extension View {
    func with(lightTheme: Theme) -> some View {
        environment(\.lightTheme, lightTheme)
    }

    func with(darkTheme: Theme) -> some View {
        environment(\.darkTheme, darkTheme)
    }
}
