@testable import DogBreedsComponent
import ComposableArchitecture
import XCTest

class DogsStoreTests: XCTestCase {
    func testStore(initialState: DogsState = .initial)
    -> TestStore<DogsState, DogsState, DogsAction, DogsAction, DogsEnvironment> {
        TestStore(
            initialState: initialState,
            reducer: DogsState.reducer,
            environment: .failing
        )
    }
}

// MARK: - Filtering
extension DogsStoreTests {
    func testFilterQueryChanged() {
        
        let store = testStore()
        let query = "buhund"
        
        store.send(.filterQueryChanged(query)) {
            $0.filterQuery = query
        }
    }
}

// MARK: - Loading
extension DogsStoreTests {
    func testDogsLoad() {
        
        let store = testStore()
        let expectedDogs = [Dog(breed: "dog", subBreeds: [])]
        store.environment.loadDogs = {
            Effect(value: expectedDogs)
        }
        
        store.send(.loadDogs)
        store.receive(.dogsLoaded(expectedDogs)) {
            $0.dogs = expectedDogs
        }
    }
}
