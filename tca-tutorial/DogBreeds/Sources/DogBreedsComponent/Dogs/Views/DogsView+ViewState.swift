extension DogsView {
    struct ViewState: Equatable {
        let filterText: String
        let loadingState: LoadingState
    }
}

// MARK: - Loading
extension DogsView.ViewState {
    enum LoadingState: Equatable {
        case loaded(breeds: [String])
        case loading
        
        var breeds: [String] {
            guard case .loaded(let breeds) = self else { return [] }
            return breeds
        }
        
        var isLoading: Bool { self == .loading }
    }
}

// MARK: - Converter
extension DogsView.ViewState {
    static func convert(from state: DogsState) -> Self {
        .init(
            filterText: state.filterQuery,
            loadingState: loadingState(from: state)
        )
    }
    
    private static func loadingState(from state: DogsState) -> LoadingState {
        if state.dogs.isEmpty { return .loading }
        
        var breeds = state.dogs.map(\.breed.capitalizedFirstLetter)
        if !state.filterQuery.isEmpty {
            breeds = breeds.filter {
                $0.lowercased().contains(state.filterQuery.lowercased())
            }
        }
        
        return .loaded(breeds: breeds)
    }
}
