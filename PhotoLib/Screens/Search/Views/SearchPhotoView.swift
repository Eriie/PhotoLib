import SwiftUI

struct SearchPhotoView: View {
    @State private var viewModel: SearchPhotoViewModel
    @State private var searchText = ""
    @State private var isSearchBarVisible = true

    init(dataSource: SearchPhotoDataSource) {
        viewModel = SearchPhotoViewModel(dataSource: dataSource)
    }

    var body: some View {
        NavigationView {
            content
            .navigationTitle("写真検索")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }

    var content: some View {
         VStack(spacing: 0) {
             
             switch viewModel.state {
                case .idle:
                    Text("結果を見るために写真を検索してください。")
                
                case .loading:
                    ProgressView()
                
                case .loaded:
                 if viewModel.resultModel.items.isEmpty {
                     emptyView
                 } else {
                     SearchPhotosListView(
                        photos: viewModel.resultModel.items
                     ) {
                         viewModel.loadMore()
                     }
                     .padding(.top, Layout.searchBarHeight)
                 }
                    
                case .error(let errorText, let action):
                    Spacer()
                    VStack {
                        Text(errorText)
                        Button(action: action, label: {
                            Text("再試行")
                                .background(Color.primary)
                        })
                    }
                    Spacer()
                }
            }
         .frame(maxWidth: .greatestFiniteMagnitude)
         .overlay(alignment: .top) {
                 HStack {
                     TextField("写真を検索", text: $searchText)
                         .textFieldStyle(.roundedBorder)
                     Button(action: {
                         viewModel.search(query: searchText)
                     }) {
                         Text("検索")
                     }
                 }
                 .padding()
                 .frame(height: Layout.searchBarHeight)
             
         }
    }
    
    var emptyView: some View {
        Text("イメージがありません")
    }
}

private enum Layout {
    static var searchBarHeight: CGFloat {
        48
    }
}
