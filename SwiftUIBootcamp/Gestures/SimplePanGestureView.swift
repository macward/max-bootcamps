//
//  SimplePanGestureView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 27/09/2023.
//

import SwiftUI

struct SimplePanGestureView: View {
    
    @GestureState private var isDetectingLongPress = false
    
    var body: some View {
        Canvas { context, size in
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.red))
            
            var squarePath = Path()
            
            for i in 0..<100 {
                
            }
        }
    }
}

#Preview {
    SimplePanGestureView()
}
