import SwiftUI

struct SearchPhotoView: View {
    @StateObject private var viewModel: SearchPhotoViewModel
    @State private var searchText = ""

    init(dataSource: SearchPhotoDataSource) {
        _viewModel = StateObject(wrappedValue: SearchPhotoViewModel(dataSource: dataSource))
    }

    var body: some View {
        NavigationView {
            content
            .navigationTitle("写真検索")
        }
    }

    var content: some View {
         VStack {
                HStack {
                    TextField("写真を検索", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        viewModel.search(query: searchText)
                    }) {
                        Text("検索")
                    }
                }
                .padding()

                Spacer()

                switch viewModel.state {
                case .idle:
                    Text("結果を見るために写真を検索してください。")
                
                case .loading:
                    ProgressView()
                
                case .loaded:
                    SearchPhotoLoadedView(
                        photos: SearchPhotoViewModelMapper.map(photos: viewModel.photos)) {
                        viewModel.loadMore()
                    }
                    
                case .error(let errorText, let action):
                    Text(errorText)
                    Button(action: action, label: {
                        Text("再試行")
                            .padding(.all, 16)
                            .background(Color.primary)
                    })
                }
             
                Spacer()
            }
    }
}
