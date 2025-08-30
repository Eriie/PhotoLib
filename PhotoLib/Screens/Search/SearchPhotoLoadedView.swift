import SwiftUI

struct SearchPhotoLoadedView: View {
    let photos: [SearchPhotoItemViewModel]
    let onScrolledToEnd: () -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(photos) { photo in
                    CacheAsyncImage(placheholder: {
                        Color.gray
                    }, url: photo.previewUrl)
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                    .clipped()
                }
            }
        }
    }
}
