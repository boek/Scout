//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

public struct Theme {
    public var primary: Color
    public var primaryVariant: Color
    public var secondary: Color
    public var secondaryVariant: Color
    public var background: Color
    public var surface: Color
    public var error: Color
    public var onPrimary: Color
    public var onSecondary: Color
    public var onBackground: Color
    public var onSurface: Color
    public var onError: Color

    init(
        primary: Color,
        primaryVariant: Color,
        secondary: Color,
        secondaryVariant: Color,
        background: Color,
        surface: Color,
        error: Color,
        onPrimary: Color,
        onSecondary: Color,
        onBackground: Color,
        onSurface: Color,
        onError: Color
    ) {
        self.primary = primary
        self.primaryVariant = primaryVariant
        self.secondary = secondary
        self.secondaryVariant = secondaryVariant
        self.background = background
        self.surface = surface
        self.error = error
        self.onPrimary = onPrimary
        self.onSecondary = onSecondary
        self.onBackground = onBackground
        self.onSurface = onSurface
        self.onError = onError
    }
}

public extension Theme {
    static func light(palette: Palette = .brand) -> Theme {
        Theme(
            primary: palette.violet.sixty,
            primaryVariant: palette.blue.fourty,
            secondary: palette.purple.sixty,
            secondaryVariant: palette.purple.fourty,
            background: palette.lightGray.ten,
            surface: palette.pink.ninety,
            error: palette.pink.ninety,
            onPrimary: palette.lightGray.zeroFive,
            onSecondary: palette.pink.ninety,
            onBackground: palette.violet.ninety,
            onSurface: palette.pink.ninety,
            onError: palette.pink.ninety
        )
    }

    static func dark(palette: Palette = .brand) -> Theme {
        var theme = Theme.light()
        theme.primary = palette.violet.zeroFive
        theme.background = palette.violet.ninety
        theme.onBackground = palette.violet.zeroFive
        return theme
    }
}


