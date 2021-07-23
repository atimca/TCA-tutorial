import Foundation

struct BreedState: Equatable {
    let dog: Dog
    var imageURL: URL?
}

// MARK: - Scope
extension BreedState {
    var view: BreedView.ViewState {
        BreedView.ViewState.convert(from: self)
    }
}
