//
//  SimpleHepticBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//
import SwiftUI
import UIKit

struct HepticBootcamp: View {
    var body: some View {
        VStack {
            Button("Impact Feedback") {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            }
            .padding()
            
            Button("Notification Feedback") {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            .padding()
            
            Button("Selection Feedback") {
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
            }
            .padding()
        }
    }
}


#Preview {
    HepticBootcamp()
}
