//
//  ButtonView.swift
//  AnimationsBootcamp
//
//  Created by Max Ward on 25/09/2023.
//

import SwiftUI

@ViewBuilder
func RoundedButton(icon: String, size: CGFloat = 24, _ action: @escaping (() -> Void)) -> some View {
    Button(action: action, label: {
        ZStack(content: {
            Image(systemName: icon)
                .font(.system(size: size))
                .foregroundStyle(Color.white)
                .frame(width: 48, height: 48)
                .overlay {
                    Circle()
                        .stroke(Color("MainBorders"))
                }
        })
    })
}
@ViewBuilder
func RecordButton(_ active: Bool, _ action: @escaping (() -> Void)) -> some View {
    
    let idleGradient = RadialGradient(colors: [Color("RBL1BG").opacity(0), Color("RBL1BG")], center: .center, startRadius: 0, endRadius: 100)
    let activeGradient = RadialGradient(colors: [Color("RBL1BGACTIVE").opacity(0.40), Color("RBL1BGACTIVE").opacity(0.8)], center: .center, startRadius: 0, endRadius: 100)
    
    ZStack {
        Circle()
            .fill(Color("RBL3BG"))
            .overlay {
                Circle().stroke(Color("RBL3STRK"), lineWidth: 1)
            }
            .frame(width: 160, height: 160)
        
        Circle()
            .fill(Color("RBL2BG"))
            .overlay {
                Circle().stroke(Color("RBL2STRK"), lineWidth: 1)
            }
            .frame(width: 110, height: 110)
        
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(active ? activeGradient : idleGradient)
                    .overlay {
                        Circle().stroke(LinearGradient(colors: [Color("RBL1STRKINIT"), Color("RBL1STRKEND")], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                    }
                    .frame(width: 80, height: 80)
                
                Image("mic-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    
                
            }
            .frame(width: 150, height: 150)
        }
    }
    
}


struct Buttons: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                RoundedButton(icon: "arrow.backward") {
                    print("")
                }
                
                RoundedButton(icon: "ellipsis") {
                    print("")
                }
                
                RecordButton(true) {
                    print("")
                }
            }
        }
        
    }
}

#Preview {
    Buttons()
}
