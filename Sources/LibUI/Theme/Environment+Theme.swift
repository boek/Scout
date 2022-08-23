//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

public struct LightThemeEnvironmentKey: EnvironmentKey {
    static public var defaultValue: Theme { .light() }
}

public struct DarkThemeEnvironmentKey: EnvironmentKey {
    static public var defaultValue: Theme { .dark() }
}

public extension EnvironmentValues {
    var theme: Theme {
        get {
            switch self.colorScheme {
            case .dark: return self.darkTheme
            case .light: return self.lightTheme
            @unknown default: fatalError()
            }
        }
    }

    var lightTheme: Theme {
        get { self[LightThemeEnvironmentKey.self] }
        set { self[LightThemeEnvironmentKey.self] = newValue }
    }

    var darkTheme: Theme {
        get { self[DarkThemeEnvironmentKey.self] }
        set { self[DarkThemeEnvironmentKey.self] = newValue }
    }
}
