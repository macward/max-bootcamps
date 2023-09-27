//
//  ScreenSpace.swift
//  AnimationsBootcamp
//
//  Created by Max Ward on 25/09/2023.
//

import SwiftUI

struct AIEllipseData: Hashable {
    var angle: CGFloat
    var opacity: CGFloat
}

struct AIScreenView: View {
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var offset: CGFloat = 0.0
    @State var angle: CGFloat = 0
    @State var circleAngle: CGFloat = 0.0
    @State private var recordActive: Bool = false
    @State private var viewContainer: [AIEllipseData] = []
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                // MARK: NAVIGATION
                HStack {
                    
                    RoundedButton(icon: "arrow.backward", size: 20) {
                        print("")
                    }
                    
                    Spacer()
                    Text("Speaking to AI bot")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundStyle(Color.white)
                    Spacer()
                    RoundedButton(icon: "ellipsis", size: 20) {
                        print("")
                    }
                }
                .padding(.horizontal, 34)
                .padding(.top, 23)
                
                HStack {
                    Text("Go a head, I’m listening")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(Color("PromptText"))
                }
                // MARK: circle animated
                ZStack {
                    Image("circle_bg")
                        .resizable()
                    
                    ZStack {
                        GeometryReader { proxy in
                            
                            let local = proxy.frame(in: .local)
                            ZStack {
                                
                                Ellipse()
                                    .stroke(.white.opacity(0.2), lineWidth: 3)
                                    .frame(width: local.width - 33, height: local.width - 55)
                                    .rotationEffect(.degrees(circleAngle))
                                
                                Ellipse()
                                    .stroke(.white.opacity(0.2), lineWidth: 3)
                                    .frame(width: local.width - 60, height: local.width - 50)
                                    .rotationEffect(.degrees(circleAngle))
                                
                                Ellipse()
                                    .stroke(.white.opacity(0.2), lineWidth: 3)
                                    .frame(width: local.width - 50, height: local.width - 60)
                                    .rotationEffect(.degrees(circleAngle))
                                
                                Ellipse()
                                    .stroke(.white.opacity(0.2), lineWidth: 3)
                                    .frame(width: local.width - 44, height: local.width - 30)
                                    .rotationEffect(.degrees(circleAngle))
                                
                                circle(width: local.width - 32, height: local.width - 64, active: recordActive)
                                    .position(x: local.midX, y: local.midY)
                                    .rotationEffect(.degrees(circleAngle))
                                
                                circle(width: local.width - 60, height: local.width - 40, active: recordActive)
                                    .rotationEffect(.degrees(circleAngle))
                                
                                circle(width: local.width - 62, height: local.width - 55, active: recordActive)
                                    .rotationEffect(.degrees(circleAngle))
                                
                                circle(width: local.width - 44, height: local.width - 49, active: recordActive)
                                    .rotationEffect(.degrees(circleAngle))
                                
                                ForEach(viewContainer, id: \.self) { properties in
                                    MyElipse()
                                        .fill(Color.white.opacity(0.08))
                                        .rotationEffect(.degrees(CGFloat(properties.angle)),
                                                        anchor: .center)
                                        .frame(width: proxy.size.width - 40, height: 50)
                                        .opacity(properties.opacity)
                                }
                            }
                        }
                        .padding(.horizontal, 40)
                    }
                }
                .offset(y: -60)
                
                // MARK: BOTTOM SPACE
                HStack (alignment: .bottom) {
                    
                    RoundedButton(icon: "list.dash.header.rectangle", size: 20) {
                        print("")
                    }
                    .padding(.bottom, 34)
                    
                    Spacer()
                    RecordButton(recordActive) {
                        withAnimation {
                            recordActive.toggle()
                        }
                    }
                    Spacer()
                    RoundedButton(icon: "xmark", size: 20) {
                        print("")
                    }
                    .padding(.bottom, 34)
                }
                .padding(.horizontal, 34)
                .padding(.bottom, 16)
                .onReceive(timer) { time in
                    handleTimerAnimation()
                    withAnimation {
                        circleAngle += 10
                    }
                }
            }
        }
        .overlay {
            Image("search_screen").resizable().scaledToFill().opacity(0)
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
#Preview {
    AIScreenView()
}
