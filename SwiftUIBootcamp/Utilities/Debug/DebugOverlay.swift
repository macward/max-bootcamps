//
//  DebugOverlay.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//

import Foundation
import SwiftUI

extension View {
    func debugLayout(_ enabled: Bool) -> some View {
        self.environment(\.debugLayout, enabled)
    }
}

enum DebugLayoutKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var debugLayout: Bool {
        get { self[DebugLayoutKey.self] }
        set { self[DebugLayoutKey.self] = newValue }
    }
}

extension View {
    func debugOverlay(_ label: String? = nil, color: Color = .red, alignment: VerticalAlignment = .center, offset: CGFloat = 0) -> some View {
        self.modifier(DebugOverlay(label: label, color: color, alignment: alignment, offset: offset))
    }
}

struct DebugOverlay: ViewModifier {
    var label: String?
    var color: Color
    var alignment: VerticalAlignment
    var offset: CGFloat
    @Environment(\.debugLayout) private var debugLayout: Bool
    
    func body(content: Content) -> some View {
        content.overlay {
            if debugLayout {
                GeometryReader { geo in
                    Color.clear.overlay(alignment: Alignment(horizontal: .center, vertical: alignment)) {
                        Color.clear
                            .frame(height: 0)
                            .overlay {
                                HStack(spacing: 0) {
                                    color.frame(width: 2, height: 16)
                                    color.frame(height: 2)
                                    Text("\(label.map { "\($0) — " } ?? "")**\(geo.size.width, format: .number.precision(.fractionLength(0)))**")
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .foregroundStyle(.white)
                                        .background(color, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .font(.callout.monospacedDigit())
                                        .layoutPriority(1)
                                    color.frame(height: 2)
                                    color.frame(width: 2, height: 16)
                                }
                                .fixedSize(horizontal: false, vertical: true)
                                .offset(y: offset)
                            }
                    }
                }
            }
        }
        .animation(.default, value: debugLayout)
    }
}
