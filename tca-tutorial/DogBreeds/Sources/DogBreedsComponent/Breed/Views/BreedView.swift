import ComposableArchitecture
import Kingfisher
import SwiftUI

struct BreedView: View {
    
    let store: Store<ViewState, ViewAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                
                KFImage(viewStore.imageURL)
                    .header()
                    
                viewStore
                    .subtitle
                    .flatMap(Text.init)
                    .font(.title)
                
                ForEach(viewStore.subBreeds, id: \.self) { breed in
                    VStack {
                        HStack {
                            Text(breed)
                            Spacer()
                        }
                        Divider()
                    }
                    .foregroundColor(.primary)
                }
                .padding()
                
            }
            .navigationBarTitle(viewStore.title)
            .onAppear { viewStore.send(.onAppear) }
        }
    }
}

#if DEBUG
struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BreedView(
                store: Store(
                    initialState: BreedView.ViewState(
                        title: "Hound",
                        subtitle: "sub-breeds",
                        subBreeds: [
                            "Afghan",
                            "Basset",
                            "Blood",
                            "English",
                            "Jbizan",
                            "Plott",
                            "Walker"
                        ],
                        imageURL: URL(string: "https://images.dog.ceo/breeds/hound-basset/n02088238_9351.jpg")
                    ),
                    reducer: .empty,
                    environment: ()
                )
            )
        }
    }
}
#endif
