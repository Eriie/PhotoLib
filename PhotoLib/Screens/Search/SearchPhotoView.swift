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
                    SearchPhotoLoadedView(
                        photos: SearchPhotoViewModelMapper.map(photos: viewModel.photos)) {
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
