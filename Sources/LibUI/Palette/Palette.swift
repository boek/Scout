//
//  File.swift
//  
//
//  Created by Jeff Boek on 8/22/22.
//

import SwiftUI

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }

}

public struct Palette {
    public struct Swatch {
        public var zeroFive: Color
        public var ten: Color
        public var twenty: Color
        public var thirty: Color
        public var fourty: Color
        public var fifty: Color
        public var sixty: Color
        public var seventy: Color
        public var eighty: Color
        public var ninety: Color

        init(
            zeroFive: Color,
            ten: Color,
            twenty: Color,
            thirty: Color,
            fourty: Color,
            fifty: Color,
            sixty: Color,
            seventy: Color,
            eighty: Color,
            ninety: Color
        ) {
            self.zeroFive = zeroFive
            self.ten = ten
            self.twenty = twenty
            self.thirty = thirty
            self.fourty = fourty
            self.fifty = fifty
            self.sixty = sixty
            self.seventy = seventy
            self.eighty = eighty
            self.ninety = ninety
        }
    }

    public var green: Swatch
    public var blue: Swatch
    public var violet: Swatch
    public var purple: Swatch
    public var pink: Swatch
    public var red: Swatch
    public var orange: Swatch
    public var yellow: Swatch
    public var lightGray: Swatch
    public var darkGray: Swatch
    public var ink: Swatch

    init(
        green: Swatch,
        blue: Swatch,
        violet: Swatch,
        purple: Swatch,
        pink: Swatch,
        red: Swatch,
        orange: Swatch,
        yellow: Swatch,
        lightGray: Swatch,
        darkGray: Swatch,
        ink: Swatch
    ) {
        self.green = green
        self.blue = blue
        self.violet = violet
        self.purple = purple
        self.pink = pink
        self.red = red
        self.orange = orange
        self.yellow = yellow
        self.lightGray = lightGray
        self.darkGray = darkGray
        self.ink = ink
    }
}

public extension Palette {
    static var brand: Palette {
        Palette(
            green: .init(
                zeroFive: Color(0xe3fff3),
                ten: Color(0xd1ffee),
                twenty: Color(0xb3ffe3),
                thirty: Color(0x88ffd1),
                fourty: Color(0x54ffbd),
                fifty: Color(0x3fe1b0),
                sixty: Color(0x2ac3a2),
                seventy: Color(0x008787),
                eighty: Color(0x005e5e),
                ninety: Color(0x08403f)
            ),
            blue: .init(
                zeroFive: Color(0xaaf2ff),
                ten: Color(0x80ebff),
                twenty: Color(0x00ddff),
                thirty: Color(0x00b3f4),
                fourty: Color(0x0090ed),
                fifty: Color(0x0060df),
                sixty: Color(0x0250bb),
                seventy: Color(0x054096),
                eighty: Color(0x073072),
                ninety: Color(0x09204d)
            ),
            violet: .init(
                zeroFive: Color(0xe7dfff),
                ten: Color(0xd9bfff),
                twenty: Color(0xcb9eff),
                thirty: Color(0xc689ff),
                fourty: Color(0xab71ff),
                fifty: Color(0x9059ff),
                sixty: Color(0x7542e5),
                seventy: Color(0x592acb),
                eighty: Color(0x45278d),
                ninety: Color(0x321c64)
            ),
            purple: .init(
                zeroFive: Color(0xf7e2ff),
                ten: Color(0xf6b8ff),
                twenty: Color(0xf68fff),
                thirty: Color(0xf770ff),
                fourty: Color(0xd74cf0),
                fifty: Color(0xb833e1),
                sixty: Color(0x952bb9),
                seventy: Color(0x722291),
                eighty: Color(0x4e1a69),
                ninety: Color(0x2b1141)
            ),
            pink: .init(
                zeroFive: Color(0xffdef0),
                ten: Color(0xffb4db),
                twenty: Color(0xff8ac5),
                thirty: Color(0xff6bba),
                fourty: Color(0xff4aa2),
                fifty: Color(0xff298a),
                sixty: Color(0xe31587),
                seventy: Color(0xc60084),
                eighty: Color(0x7f145b),
                ninety: Color(0x50134b)
            ),
            red: .init(
                zeroFive: Color(0xffdfe7),
                ten: Color(0xffbdc5),
                twenty: Color(0xff9aa2),
                thirty: Color(0xff848b),
                fourty: Color(0xff6a75),
                fifty: Color(0xff4f5e),
                sixty: Color(0xe22850),
                seventy: Color(0xc50042),
                eighty: Color(0x810220),
                ninety: Color(0x440306)
            ),
            orange: .init(
                zeroFive: Color(0xfff4de),
                ten: Color(0xffd5b2),
                twenty: Color(0xffb587),
                thirty: Color(0xffa266),
                fourty: Color(0xff8a50),
                fifty: Color(0xff7139),
                sixty: Color(0xe25920),
                seventy: Color(0xcc3d00),
                eighty: Color(0x9e280b),
                ninety: Color(0x7c1504)
            ),
            yellow: .init(
                zeroFive: Color(0xffffcc),
                ten: Color(0xffff98),
                twenty: Color(0xffea80),
                thirty: Color(0xffd567),
                fourty: Color(0xffbd4f),
                fifty: Color(0xffa436),
                sixty: Color(0xe27f2e),
                seventy: Color(0xc45a27),
                eighty: Color(0xa7341f),
                ninety: Color(0x960e18)
            ),
            lightGray: .init(
                zeroFive: Color(0xffffff),
                ten: Color(0xf9f9fb),
                twenty: Color(0xf0f0f4),
                thirty: Color(0xe0e0e6),
                fourty: Color(0xcfcfd8),
                fifty: Color(0xbfbfc9),
                sixty: Color(0xafafba),
                seventy: Color(0x9f9fad),
                eighty: Color(0x8f8f9e),
                ninety: Color(0x80808f)
            ),
            darkGray: .init(
                zeroFive: Color(0x5b5b66),
                ten: Color(0x52525e),
                twenty: Color(0x4a4a55),
                thirty: Color(0x42414d),
                fourty: Color(0x3a3944),
                fifty: Color(0x32313c),
                sixty: Color(0x2b2a33),
                seventy: Color(0x23222b),
                eighty: Color(0x1c1b22),
                ninety: Color(0x15141a)
            ),
            ink: .init(
                zeroFive: Color(0x393473),
                ten: Color(0x342f6d),
                twenty: Color(0x312a64),
                thirty: Color(0x2e255d),
                fourty: Color(0x2b2156),
                fifty: Color(0x291d4f),
                sixty: Color(0x271948),
                seventy: Color(0x241541),
                eighty: Color(0x20123a),
                ninety: Color(0x1d1133)
            )
        )
    }
}

