@testable import DogBreedsComponent
import XCTest

class BreedViewStateConverterTest: XCTestCase {
    
    func testViewStateTitleGoesFromFirstLetterCapitalizedStatesDogsBreed() {
        // Given
        let dog = Dog(breed: "dog", subBreeds: [])
        // When
        let viewState = BreedView.ViewState.convert(from: BreedState(dog: dog, imageURL: nil))
        // Then
        XCTAssertEqual(viewState.title, "Dog")
    }
    
    func testViewStateSubTitleIsSubBreedsIfStatesSubBreedsArrayIsNotEmpty() {
        // Given
        let dog = Dog(breed: "", subBreeds: ["0"])
        // When
        let viewState = BreedView.ViewState.convert(from: BreedState(dog: dog, imageURL: nil))
        // Then
        XCTAssertEqual(viewState.subtitle, "Sub-breeds")
    }
    
    func testViewStateSubBreedsGoFromFirstLetterCapitalizedStatesSubBreeds() {
        // Given
        let dog = Dog(breed: "", subBreeds: ["abc", "def"])
        // When
        let viewState = BreedView.ViewState.convert(from: BreedState(dog: dog, imageURL: nil))
        // Then
        XCTAssertEqual(viewState.subBreeds, ["Abc", "Def"])
    }
    
    func testViewStateImageURLGoesFromStatesImageURL() {
        // Given
        let url = URL(string: "dog.com")
        // When
        let viewState = BreedView.ViewState.convert(from: BreedState(dog: Dog(breed: "", subBreeds: []), imageURL: url))
        // Then
        XCTAssertEqual(viewState.imageURL, url)
    }
}
