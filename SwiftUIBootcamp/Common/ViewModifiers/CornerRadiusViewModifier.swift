//
//  CornerRadiusViewModifier.swift
//  SwiftUIBootcamp
//
//  Created by Max on 31/05/2024.
//

import Foundation
import SwiftUI

public struct CornerRadiusViewModifier: ViewModifier {
    
    public enum CornerRadiusSize {
        case small
        case medium
        case large
        case custom(CGFloat)

        var value: CGFloat {
            switch self {
            case .small:
                return 4 // o el valor que consideres para 'small'
            case .medium:
                return 8 // valor para 'medium'
            case .large:
                return 16 // valor para 'large'
            case .custom(let radius):
                return radius
            }
        }
    }

    private var size: CornerRadiusSize
    
    public init(size: CornerRadiusSize = .medium) {
        self.size = size
    }
    
    public func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: size.value))
    }
}

public extension View {
    func cornerRadius(_ size: CornerRadiusViewModifier.CornerRadiusSize = .medium) -> some View {
        modifier(CornerRadiusViewModifier(size: size))
    }
}
