//
//  Models.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 30/09/2023.
//

import SwiftUI

struct ColorObject: Hashable {
    var color: Color
}

struct ColorObjects {
    static func list() -> [ColorObject] {
        return [
            ColorObject(color: .blue1),
            ColorObject(color: .blue2),
            ColorObject(color: .blue3),
            ColorObject(color: .blue4),
            ColorObject(color: .blue1),
            ColorObject(color: .green1),
            ColorObject(color: .green2),
            ColorObject(color: .green3),
            ColorObject(color: .green4),
            ColorObject(color: .green5),
        ]
    }
}
