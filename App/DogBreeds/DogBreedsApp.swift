import ComposableArchitecture
import DogBreedsComponent
import SwiftUI

@main
struct DogBreedsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView(
                    store: Store(
                        initialState: .initial,
                        reducer: AppState.reducer,
                        environment: ()
                    )
                )
            }
        }
    }
}

#if DEBUG
struct DogBreedsApp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RootView(
                store: Store(
                    initialState: .initial,
                    reducer: AppState.reducer,
                    environment: ()
                )
            )
        }
    }
}
#endif
