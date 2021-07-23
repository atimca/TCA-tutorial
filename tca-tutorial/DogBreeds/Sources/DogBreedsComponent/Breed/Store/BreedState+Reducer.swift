import ComposableArchitecture

extension BreedState {
    static let reducer = Reducer<BreedState, BreedAction, BreedEnvironment> { state, action, environment in
        switch action {
        case .breedImageURLReceived(let url):
            state.imageURL = url
            return .none
        case .getBreedImageURL:
            return environment
                .loadDogImage(state.dog.breed)
                .map(BreedAction.breedImageURLReceived)
        }
    }
}
