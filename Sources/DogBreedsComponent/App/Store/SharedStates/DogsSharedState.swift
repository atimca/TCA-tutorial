extension AppState {
    var dogsState: DogsState {
        get {
            DogsState(internalState: dogsInternal, dogs: dogs)
        }
        set {
            dogsInternal = .init(state: newValue)
            dogs = newValue.dogs
        }
    }
}

extension DogsState {
    init(
        internalState: DogsInternalState,
        dogs: [Dog]
    ) {

        self.init(
            filterQuery: internalState.filterQuery,
            dogs: dogs
        )
    }
}

struct DogsInternalState: Equatable {
    var filterQuery: String

    init() {
        self.filterQuery = ""
    }

    init(state: DogsState) {
        self.filterQuery = state.filterQuery
    }
}
