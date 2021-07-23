public struct AppState: Equatable {
    var dogs: [Dog]
    var dogsInternal = DogsInternalState()
    var breedState: BreedState?
    
    public static let initial = AppState(dogs: [], breedState: nil)
}
