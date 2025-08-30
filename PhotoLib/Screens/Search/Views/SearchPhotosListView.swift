import SwiftUI

struct SearchPhotosListView: View {
    let photos: [SearchPhotoItemViewModel]
    let onScrolledToEnd: () -> Void
    
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var selectedPhoto: SearchPhotoItemViewModel?
    
    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: Layout.cellSizeMin), spacing: 1)],
            spacing: 1
        ) {
            ForEach(photos) { photo in
                Button(action: {
                    selectedPhoto = photo
                }) {
                    ImageView(imageSource: photo.previewUrl, placeholder: {
                        photo.avgColor
                            .scaledToFill()
                    })
                    .aspectRatio(contentMode: .fill)
                    .frame(minHeight: Layout.cellSizeMin)
                    .clipped()
                }
                .buttonStyle(ScaleButtonStyle())
                .onAppear {
                    if photo == photos.last {
                        onScrolledToEnd()
                    }
                }
            }
        }
        .onGeometryChange(for: CGFloat.self) { geometryProxy in
            geometryProxy.size.width
        } action: { newWidth in
            screenWidth = newWidth
        }
        .sheet(item: $selectedPhoto) { photo in
            PhotoDetailsView(photo: photo)
        }
    }
}

enum Layout {
    static let cellSizeMin: CGFloat = 140
}
