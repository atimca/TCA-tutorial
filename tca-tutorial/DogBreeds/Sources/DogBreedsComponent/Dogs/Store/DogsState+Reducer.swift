import ComposableArchitecture

extension DogsState {
    static let reducer = Reducer<DogsState, DogsAction, DogsEnvironment> { state, action, environment in
        switch action {
        case .breedWasSelected:
            return .none
        case .dogsLoaded(let dogs):
            state.dogs = dogs
            return .none
        case .filterQueryChanged(let query):
            state.filterQuery = query
            return .none
        case .loadDogs:
            return environment
                .loadDogs()
                .map(DogsAction.dogsLoaded)
        }
    }
}
