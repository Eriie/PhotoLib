import SwiftUI

struct SearchPhotoView: View {
    @State private var viewModel: SearchPhotoViewModel
    @State private var searchText = ""
    @State private var isSearchBarVisible = true
    
    init(dataSource: SearchPhotoDataSource) {
        viewModel = SearchPhotoViewModel(dataSource: dataSource)
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("写真検索")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                searchField
                Spacer()
                switch viewModel.state {
                case .idle:
                    Text("結果を見るために写真を検索してください。")
                        .multilineTextAlignment(.center)
                        .padding()
                case .loading:
                    ProgressView()
                case .loaded:
                    if viewModel.resultModel.items.isEmpty {
                        emptyView
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        SearchPhotosListView(
                            photos: viewModel.resultModel.items
                        ) {
                            viewModel.loadMore()
                        }
                    }
                    
                case .error(let errorText, let action):
                    errorView(errorText: errorText, action: action)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Spacer()
            }
            .frame(minHeight: UIScreen.main.bounds.height - 200) // Ensure minimum height for centering
        }
    }
    
    private var searchField: some View {
        HStack {
            TextField("写真を検索", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .onSubmit { viewModel.search(query: searchText) }
            Button(action: {
                viewModel.search(query: searchText)
            }) {
                Text("検索")
            }
        }
        .padding()
    }
    
    private var emptyView: some View {
        Text("イメージがありません")
    }
    
    @ViewBuilder
    private func errorView(errorText: String, action: @escaping () -> Void) -> some View {
        VStack {
            Text(errorText)
            Button(action: action, label: {
                Text("再試行")
                    .background(Color.primary)
            })
        }
    }
}

