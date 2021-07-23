import ComposableArchitecture

extension AppState {
    static let reducerCore = Reducer<AppState, AppAction, Void> { state, action, _ in
        switch action {
        case .breed:
            return .none
        case .breedsDisappeared:
            state.breedState = nil
            return .none
        case .dogs(.breedWasSelected(let breed)):
            guard let dog = state.dogs.first(where: { $0.breed.lowercased() == breed.lowercased() }) else { fatalError() }
            state.breedState = BreedState(dog: dog, imageURL: nil)
            return .none
        case .dogs:
            return .none
        }
    }
}

public extension AppState {
    static let reducer = Reducer<AppState, AppAction, Void>
        .combine(
            AppState.reducerCore,
            DogsState
                .reducer
                .pullback(
                    state: \.dogsState,
                    action: /AppAction.dogs,
                    environment: { _ in DogsEnvironment.live }
                ),
            BreedState
                .reducer
                .optional()
                .pullback(
                    state: \.breedState,
                    action: /AppAction.breed,
                    environment: { _ in BreedEnvironment.live }
                )
        )
}
