
import SwiftUI

enum ViewDataState: Equatable {
    /// Error loading data.
    case error(ApiError)

    /// Data is being fetched for the first time.
    case initialLoading

    /// Data is being fetched.
    case loading

    /// Data has been loaded successfully.
    case loaded
}

enum ApiError: Error {
    case parsingError
    case networkError
    case unknown
}

struct BaseViewWithState<LoadedContent: View,
                         LoadingContent: View,
                         ErrorContent: View,
                         InitialContent: View>: View {
    
    private var state: ViewDataState
    var loadedContent: () -> LoadedContent
    var initialContent: (() -> InitialContent)?
    var loadingContent: (() -> LoadingContent)?
    var errorContent: (Error) -> ErrorContent
    
    init(
        state: ViewDataState,
        loadedContent: @escaping () -> LoadedContent,
        errorContent: @escaping (Error) -> ErrorContent,
        initialContent: (() -> InitialContent)? = nil,
        loadingContent: (() -> LoadingContent)? = nil)
    {
        self.state = state
        self.initialContent = initialContent
        self.loadedContent = loadedContent
        self.loadingContent = loadingContent
        self.errorContent = errorContent
    }
    
    @ViewBuilder
    var body: some View {
        ZStack {
            Color.primaryBg.ignoresSafeArea()
            switch state {
            case .initialLoading:
                if let initialContent = initialContent {
                    initialContent()
                } else {
                    EmptyView()
                }
            case .loaded:
                loadedContent()
            case .loading:
                if let loadingContent = loadingContent {
                    loadingContent()
                } else {
                     EmptyView()
                }
            case .error(let error):
                errorContent(error)
            }
        }
    }
}


struct ContainerWithDataState: View {
    @State var state: ViewDataState = .loading
    var body: some View {
        Text("")
    }
}


#Preview(body: {
    ContainerWithDataState()
})
