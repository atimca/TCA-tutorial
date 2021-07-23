@testable import DogBreedsComponent
import ComposableArchitecture
import XCTest

class AppStoreTests: XCTestCase {
    func testStore(initialState: AppState)
    -> TestStore<AppState, AppState, AppAction, AppAction, Void> {
        TestStore(
            initialState: initialState,
            reducer: AppState.reducerCore,
            environment: ()
        )
    }
}

// MARK: - Navigation
extension AppStoreTests {
    func testNavigation() {
        
        let breedName = "Hound"
        let dog = Dog(breed: breedName, subBreeds: ["subreed1", "subbreed2"])
        
        let initialState = AppState(
            dogs: [Dog(breed: "anotherDog0", subBreeds: []), dog, Dog(breed: "anotherDog1", subBreeds: [])]
        )
        let store = testStore(initialState: initialState)
        
        store.send(.dogs(.breedWasSelected(name: breedName))) {
            $0.breedState = BreedState(dog: dog, imageURL: nil)
        }
        
        store.send(.breedsDisappeared) {
            $0.breedState = nil
        }
    }
}
