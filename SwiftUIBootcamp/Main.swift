//
//  SwiftUIBootcampApp.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 26/09/2023.
//

import SwiftUI

@main
struct SwiftUIBootcampApp: App {
    @State private var debugLayout: Bool = true
    var body: some Scene {
        WindowGroup {
            CategoryListView()
                .debugLayout(debugLayout)
        }
    }
}
