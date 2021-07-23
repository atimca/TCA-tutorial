@testable import DogBreedsComponent
import ComposableArchitecture
import XCTest

class BreedStoreTests: XCTestCase {
    func testStore(initialState: BreedState)
    -> TestStore<BreedState, BreedState, BreedAction, BreedAction, BreedEnvironment> {
        TestStore(
            initialState: initialState,
            reducer: BreedState.reducer,
            environment: .failing
        )
    }
}

// MARK: - Image Loading
extension BreedStoreTests {
    func testBreedImageLoad() {
        
        let breedName = "Breed"
        let initialState = BreedState(dog: Dog(breed: breedName, subBreeds: []), imageURL: nil)
        let store = testStore(initialState: initialState)
        
        let expectedURL = URL(string: "breed.com")
        
        store.environment.loadDogImage = {
            XCTAssertEqual($0, breedName)
            return Effect(value: expectedURL)
        }
        
        store.send(.getBreedImageURL)
        store.receive(.breedImageURLReceived(expectedURL)) {
            $0.imageURL = expectedURL
        }
    }
}
