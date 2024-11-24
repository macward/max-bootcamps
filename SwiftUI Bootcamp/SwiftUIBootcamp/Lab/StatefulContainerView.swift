//
//  StatefulContainerView.swift
//  SwiftUIBootcamp
//
//  Created by Max on 07/06/2024.
//

import SwiftUI

enum ViewState {
    case loading
    case loaded
    case error
}

struct StatefulView<Content: View, ErrorView: View>: View {
    @State private var currentState: ViewState = .loading
    let content: Content
    let errorView: ErrorView

    var body: some View {
        VStack {
            switch currentState {
            case .loading:
                LoadingView()
            case .loaded:
                content
            case .error:
                errorView
            }
        }
        .onAppear {
            // Simulación de cambio de estado para la demostración
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.currentState = .loaded
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading...")
                .font(.headline)
                .padding()
        }
    }
}

struct StatefulContainerView: View {
    var body: some View {
        StatefulView(
            content: LoadedView().redacted(reason: .placeholder),
            errorView: ErrorView()
        )
    }
}

struct LoadedView: View {
    var body: some View {
        Text("Data Loaded Successfully")
            .font(.largeTitle)
            .padding()
    }
}

struct ErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Text("An Error Occurred")
                .font(.headline)
                .padding()
        }
    }
}


#Preview {
    StatefulContainerView()
}
