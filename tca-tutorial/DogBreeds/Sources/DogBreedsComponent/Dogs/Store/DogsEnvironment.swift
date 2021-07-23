import ComposableArchitecture

struct DogsEnvironment {
    var loadDogs: () -> Effect<[Dog], Never>
}

#if DEBUG
extension DogsEnvironment {
    static let failing = DogsEnvironment(
        loadDogs: { .failing("DogsEnvironment.loadDogs") }
    )
}

extension DogsEnvironment {
    static let fake = DogsEnvironment(
        loadDogs: {
            Effect(
                value: [
                    Dog(breed: "affenpinscher", subBreeds: []),
                    Dog(breed: "bulldog", subBreeds: ["boston", "english", "french"])
                ]
            )
            .delay(for: .seconds(2), scheduler: DispatchQueue.main)
            .eraseToEffect()
        }
    )
}
#endif

extension DogsEnvironment {
    
    private struct DogsResponse: Codable {
        let message: [String: [String]]
    }
    
    static let live = DogsEnvironment(
        loadDogs: {
            URLSession
                .shared
                .dataTaskPublisher(for: URL(string: "https://dog.ceo/api/breeds/list/all")!)
                .map(\.data)
                .decode(type: DogsResponse.self, decoder: JSONDecoder())
                .map { response in
                    response
                        .message
                        .map(Dog.init)
                        .sorted { $0.breed < $1.breed }
                }
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .eraseToEffect()
        }
    )
}
