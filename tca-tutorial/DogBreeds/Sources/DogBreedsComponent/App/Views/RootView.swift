import ComposableArchitecture
import SwiftUI

public struct RootView: View {
    
    let store: Store<AppState, AppAction>
    let dogsView: DogsView

    public init(store: Store<AppState, AppAction>) {
        self.store = store
        dogsView = DogsView(
            store: store.scope(
                state: \.dogsState.view,
                action: { local -> AppAction in
                    AppAction.dogs(
                        DogsAction.view(local)
                    )
                }
            )
        )
    }
    
    public var body: some View {
        WithViewStore(store.scope(state: \.breedState)) { viewStore in
            HStack {
                dogsView
                NavigationLink(
                    destination: breedView,
                    isActive: viewStore.binding(
                        get: { $0 != nil },
                        send: .breedsDisappeared
                    ),
                    label: EmptyView.init
                )
            }
        }
    }
    
    var breedView: some View {
        IfLetStore(
            store.scope(
                state: \.breedState?.view,
                action: { local -> AppAction in
                    AppAction.breed(
                        BreedAction.view(local)
                    )
                }
            ),
            then: BreedView.init(store:)
        )
    }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
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
