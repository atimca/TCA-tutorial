public enum DogsAction: Equatable {
    case breedWasSelected(name: String)
    case dogsLoaded([Dog])
    case filterQueryChanged(String)
    case loadDogs
}

// MARK: - Scope
extension DogsAction {
    static func view(_ localAction: DogsView.ViewAction) -> Self {
        switch localAction {
        case .cellWasSelected(let breed):
            return .breedWasSelected(name: breed)
        case .onAppear:
            return .loadDogs
        case .filterTextChanged(let newValue):
            return .filterQueryChanged(newValue)
        }
    }
}
