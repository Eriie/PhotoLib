import SwiftUI

struct PhotoGridView: View {
    @StateObject private var viewModel: PhotoGridViewModel
    @State private var searchText = ""

    init(dataSource: PhotoGridDataSource) {
        _viewModel = StateObject(wrappedValue: PhotoGridViewModel(dataSource: dataSource))
    }

    var body: some View {
        NavigationView {
            content
            .navigationTitle("Photo Search")
        }
    }

    var content: some View {
         VStack {
                HStack {
                    TextField("Search for photos", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        viewModel.search(query: searchText)
                    }) {
                        Text("Search")
                    }
                }
                .padding()

                Spacer()

                switch viewModel.state {
                case .idle:
                    Text("Search for photos to see results.")
                
                case .loading:
                    ProgressView()
                
                case .loaded:
                    PhotoGridLoadedView(
                        photos: PhotoUIMapper.map(photos: viewModel.photos)) {
                        viewModel.loadMore()
                    }
                    
                case .error(let errorText, let action):
                    Text(errorText)
                    Button(action: action, label: {
                        Text("Retry")
                            .padding(.all, 16)
                            .background(Color.primary)
                    })
                }
             
                Spacer()
            }
    }
}
