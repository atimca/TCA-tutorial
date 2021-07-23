struct DogsState: Equatable {
    var filterQuery: String
    var dogs: [Dog]
    
    static let initial = DogsState(filterQuery: "", dogs: [])
}

// MARK: - Scope
extension DogsState {
    var view: DogsView.ViewState {
        DogsView.ViewState.convert(from: self)
    }
}
