//
//  Models.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 30/09/2023.
//

import SwiftUI

struct ImageObject: Identifiable {
    private (set) var id: UUID = .init()
    var image: String
}

struct ColorObject: Hashable, Identifiable {
    let id: UUID = UUID()
    let color: Color
}

extension ColorObject {
    static var mock: [ColorObject] {
        return [
            ColorObject(color: .blue1),
            ColorObject(color: .blue2),
            ColorObject(color: .blue3),
            ColorObject(color: .blue4),
            ColorObject(color: .blue5),
            ColorObject(color: .green1),
            ColorObject(color: .green2),
            ColorObject(color: .green3),
            ColorObject(color: .green4),
            ColorObject(color: .green5),
            ColorObject(color: .pink),
            ColorObject(color: .indigo),
            ColorObject(color: .yellow),
            ColorObject(color: .green),
            ColorObject(color: .blue),
            ColorObject(color: .cyan),
            ColorObject(color: .orange),
            ColorObject(color: .purple),
            ColorObject(color: .mint),
            ColorObject(color: .brown)
        ]
    }
    
    static var colors: [Color] {
        ColorObject.mock.map {$0.color}
    }
}
