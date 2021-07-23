extension DogsView {
    enum ViewAction: Equatable {
        case cellWasSelected(breed: String)
        case onAppear
        case filterTextChanged(String)
    }
}
