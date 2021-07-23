import Foundation

public enum BreedAction: Equatable {
    case breedImageURLReceived(URL?)
    case getBreedImageURL
}

// MARK: - Scope
extension BreedAction {
    static func view(_ localAction: BreedView.ViewAction) -> Self {
        switch localAction {
        case .onAppear:
            return .getBreedImageURL
        }
    }
}
