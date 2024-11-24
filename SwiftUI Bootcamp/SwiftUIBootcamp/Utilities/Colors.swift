//
//  Colors.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI

struct AppColor {
    
    var gradient1: LinearGradient {
        return LinearGradient(colors: [Color("Blue1"), Color("Blue2")],
                              startPoint: .topLeading,
                              endPoint: .bottomTrailing)
    }
    
    var gradient2: LinearGradient {
        return LinearGradient(colors: [Color("Blue2"), Color("Blue3")],
                              startPoint: .topLeading,
                              endPoint: .bottomTrailing)
    }
    
    var gradient3: LinearGradient {
        LinearGradient(colors: [Color("Blue3"), Color("Blue4")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
    
    var gradient4: LinearGradient {
        LinearGradient(colors: [Color("Blue4"), Color("Blue5")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
    
    var gradient5: LinearGradient {
        LinearGradient(colors: [Color("Blue5"), Color("Blue1")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
    
}

enum Colors {
    
    case BlueGradient1
    case BlueGradient2
    case BlueGradient3
    case BlueGradient4
    case BlueGradient5
    
    var gradient: LinearGradient {
        switch self {
        case .BlueGradient1: return LinearGradient(colors: [Color("Blue1"), Color("Blue2")],
                                                   startPoint: .bottomLeading,
                                                   endPoint: .bottomTrailing)
            
        case .BlueGradient2: return LinearGradient(colors: [Color("Blue2"), Color("Blue3")],
                                                   startPoint: .bottomLeading,
                                                   endPoint: .bottomTrailing)
            
        case .BlueGradient3: return LinearGradient(colors: [Color("Blue3"), Color("Blue4")],
                                                   startPoint: .bottomLeading,
                                                   endPoint: .bottomTrailing)
            
        case .BlueGradient4: return LinearGradient(colors: [Color("Blue4"), Color("Blue5")],
                                                   startPoint: .bottomLeading,
                                                   endPoint: .bottomTrailing)
            
        case .BlueGradient5: return LinearGradient(colors: [Color("Blue5"), Color("Blue1")],
                                                   startPoint: .bottomLeading,
                                                   endPoint: .bottomTrailing)
        }
    }
}
