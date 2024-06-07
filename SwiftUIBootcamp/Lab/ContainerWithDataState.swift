
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
                            InitialContent: View,
                            ErrorContent: View>: View {
    
    private var state: ViewDataState
    @ViewBuilder var initialContent: () -> InitialContent
    @ViewBuilder var loadedContent: () -> LoadedContent
    @ViewBuilder var loadingContent: () -> LoadingContent
    @ViewBuilder var errorContent: (ApiError) -> ErrorContent
    
    init(
        state: ViewDataState,
        initialContent: @escaping () -> InitialContent,
        loadedContent: @escaping () -> LoadedContent,
        loadingContent: @escaping () -> LoadingContent,
        errorContent: @escaping (ApiError) -> ErrorContent)
    {
        self.state = state
        self.initialContent = initialContent
        self.loadedContent = loadedContent
        self.loadingContent = loadingContent
        self.errorContent = errorContent
    }
    
    var body: some View {
        ZStack {
            Color.primaryBg.ignoresSafeArea()
            switch state {
            case .initialLoading:
                initialContent()
            case .loaded:
                loadedContent()
            case .loading:
                loadingContent()
            case .error(let error):
                errorContent(error)
            }
        }
    }
    
}

struct ContainerWithDataState: View {
    @State var state: ViewDataState = .initialLoading
    var body: some View {
        BaseViewWithState(state: state) {
            EmptyView()
        } loadedContent: {
            EmptyView()
        } loadingContent: {
            EmptyView()
        } errorContent: { error in
            switch error {
            case .networkError:
                EmptyView()
            case .parsingError:
                EmptyView()
            case .unknown:
                EmptyView()
            }
        }
    }
}


#Preview(body: {
    ContainerWithDataState()
})
