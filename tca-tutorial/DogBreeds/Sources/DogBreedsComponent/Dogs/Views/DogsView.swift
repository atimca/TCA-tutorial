import ComposableArchitecture
import SwiftUI

struct DogsView: View {
    
    let store: Store<ViewState, ViewAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                
                if viewStore.loadingState.isLoading {
                    ProgressView()
                } else {
                    searchBar(for: viewStore)
                    breedsList(for: viewStore)
                }
                
            }
            .navigationBarTitle("Dogs")
            .onAppear { viewStore.send(.onAppear) }
        }
    }
    
    @ViewBuilder
    private func searchBar(for viewStore: ViewStore<ViewState, ViewAction>) -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(
                "Filter breeds",
                text: viewStore.binding(
                    get: \.filterText,
                    send: ViewAction.filterTextChanged
                )
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .disableAutocorrection(true)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func breedsList(for viewStore: ViewStore<ViewState, ViewAction>) -> some View {
        ScrollView {
            ForEach(viewStore.loadingState.breeds, id: \.self) { breed in
                VStack {
                    Button(action: { viewStore.send(.cellWasSelected(breed: breed)) }) {
                        HStack {
                            Text(breed)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    Divider()
                }
                .foregroundColor(.primary)
            }
            .padding()
        }
    }
}

#if DEBUG
struct DogsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DogsView(
                store: Store(
                    initialState: DogsView.ViewState(
                        filterText: "",
                        loadingState: .loaded(
                            breeds: [
                                "affenpinscher",
                                "african",
                                "airedale",
                                "akita",
                                "appenzeller",
                                "australian",
                                "basenji",
                                "beagle",
                                "bluetick"
                            ]
                        )
                    ),
                    reducer: .empty,
                    environment: ()
                )
            )
        }
        
        NavigationView {
            DogsView(
                store: Store(
                    initialState: DogsView.ViewState(
                        filterText: "",
                        loadingState: .loading
                    ),
                    reducer: .empty,
                    environment: ()
                )
            )
        }
        
        NavigationView {
            DogsView(
                store: Store(
                    initialState: DogsState.initial,
                    reducer: DogsState.reducer,
                    environment: DogsEnvironment.fake
                )
                .scope(
                    state: \.view,
                    action: DogsAction.view
                )
            )
        }
    }
}
#endif
