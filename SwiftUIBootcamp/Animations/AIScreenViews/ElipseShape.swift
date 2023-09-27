//
//  ElipseShape.swift
//  AnimationsBootcamp
//
//  Created by Max Ward on 25/09/2023.
//

import SwiftUI

struct MyElipse: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        p.addEllipse(in: CGRect(origin: CGPoint(x: rect.minY, y: rect.midY), size: rect.size))
        
        let sp = p.strokedPath(.init(lineWidth: 1))
        return sp
    }
}
