import ComposableArchitecture

struct BreedEnvironment {
    var loadDogImage: (_ breed: String) -> Effect<URL?, Never>
}

#if DEBUG
extension BreedEnvironment {
    static let failing = BreedEnvironment(
        loadDogImage: { _ in .failing("DogsEnvironment.loadDogImage") }
    )
}

extension BreedEnvironment {
    static let fake = BreedEnvironment(
        loadDogImage: { _ in
            Effect(value: URL(string: "https://images.dog.ceo/breeds/hound-blood/n02088466_9069.jpg"))
                .delay(for: .seconds(2), scheduler: DispatchQueue.main)
                .eraseToEffect()
        }
    )
}
#endif

extension BreedEnvironment {
    
    private struct BreedImageResponse: Codable {
        let message: String?
    }
    
    static let live = BreedEnvironment(
        loadDogImage: { breed in
            URLSession
                .shared
                .dataTaskPublisher(for: URL(string: "https://dog.ceo/api/breed/\(breed)/images/random")!)
                .map(\.data)
                .decode(type: BreedImageResponse.self, decoder: JSONDecoder())
                .compactMap(\.message)
                .map(URL.init(string:))
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .eraseToEffect()
        }
    )
}
