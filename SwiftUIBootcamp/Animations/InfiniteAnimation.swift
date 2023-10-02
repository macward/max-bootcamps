//
//  InfiniteAnimation.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 01/10/2023.
//

import SwiftUI

struct InfiniteAnimation: View {
    
    @State var angle: CGFloat = 0
    @State private var isRotating: CGFloat = 0
    @State private var recordActive: Bool = false
    @State private var viewContainer: [AIEllipseData] = []
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 1).speed(0.4)
            .repeatForever(autoreverses: false)
    }
    
    var foreverAnimationBG: Animation {
        Animation.linear(duration: 1).speed(0.14)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        BaseView {
            VStack {
                Spacer()
                ZStack {
                    GeometryReader(content: { proxy in
                        let local = proxy.frame(in: .local)
                        ForEach(0...10, id: \.self) { _ in
                            circle(width: local.width - CGFloat.random(in: 30...60), height: local.width - CGFloat.random(in: 30...70), active: recordActive)
                                .position(x: local.midX, y: local.midY)
                                .opacity(CGFloat.random(in: 0.3...1))
                                .rotationEffect(.degrees(isRotating))
                                .animation(foreverAnimation, value: isRotating)
                        }
                        circleBg(width: proxy.size.width - 40)
                            .position(x: local.midX, y: local.midY)
                            .rotationEffect(.degrees(isRotating))
                            .animation(foreverAnimationBG, value: isRotating)
                            .opacity(0.2)
                            
                    })
                }
                Spacer()
            }
            .onAppear {
                withAnimation(.linear(duration: 1).speed(0.4)
                        .repeatForever(autoreverses: false)) {
                    isRotating = 360.0
                }
            }
        }
    }
    
    @ViewBuilder
    func circle(width: CGFloat, height: CGFloat, active: Bool) -> some View {
        ZStack {
            Ellipse()
                .stroke(!active ? .white : .red, lineWidth: 3)
                .frame(width: width, height: height)

            Ellipse()
                .stroke(.white.opacity(0.03), lineWidth: 10)
                .frame(width: width, height: height)
                .shadow(color: active ? .red : .white.opacity(0.3), radius: !active ? 4 : 10)
        }
    }
    
    @ViewBuilder
    func circleBg(width: CGFloat) -> some View {
        let angle: CGFloat = 5
        ZStack {
            ForEach(0..<20, id: \.self) { index in
                MyElipse()
                    .fill(Color.white.opacity((Double(index) + 1.0) / 30.0))
                    .rotationEffect(.degrees(CGFloat(angle * CGFloat(index))),
                                    anchor: .center)
                    .frame(width: width, height: 50)
                    .opacity(1)
            }
        }
    }
    
    private func handleTimerAnimation() {
        if angle == 360 {
            angle = 0
        }
        angle += 5
        if viewContainer.count == 30 {
            viewContainer.removeFirst()
        }
        viewContainer.append(AIEllipseData(angle: angle, opacity: 1))
        for i in 0...(viewContainer.count - 1) {
            let opacity: CGFloat = (CGFloat(i) / CGFloat(29))
            viewContainer[i].opacity = opacity
        }
    }
}


struct BaseView<Content: View>: View {
    
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            content
        }
        
    }
}


#Preview {
    InfiniteAnimation()
}
