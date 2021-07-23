import Foundation

extension BreedView {
    struct ViewState: Equatable {
        let title: String
        let subtitle: String?
        let subBreeds: [String]
        let imageURL: URL?
    }
}

// MARK: - Converter
extension BreedView.ViewState {
    static func convert(from state: BreedState) -> Self {
        .init(
            title: state.dog.breed.capitalizedFirstLetter,
            subtitle: state.dog.subBreeds.isEmpty ? nil : "Sub-breeds",
            subBreeds: state.dog.subBreeds.map(\.capitalizedFirstLetter),
            imageURL: state.imageURL
        )
    }
}
