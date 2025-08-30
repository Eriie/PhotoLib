import SwiftUI

struct SearchPhotosListView: View {
    let photos: [SearchPhotoItemViewModel]
    let onScrolledToEnd: () -> Void
    
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    private var cellMinSize: CGFloat {
        let columnCount = numberOfColumns(for: screenWidth)
        return screenWidth / CGFloat(columnCount)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns(for: screenWidth), spacing: 1) {
                ForEach(photos) { photo in
                    
                    ImageView(imageSource: photo.previewUrl, placeholder: {
                        photo.avgColor
                            .scaledToFill()
                    })
                    .frame(height: cellMinSize)
                    .scaledToFit()
                    .onAppear {
                        if photo == photos.last {
                            onScrolledToEnd()
                        }
                    }
                }
            }
        }
        .onGeometryChange(for: CGFloat.self) { geometryProxy in
            geometryProxy.size.width
        } action: { newWidth in
            screenWidth = newWidth
        }
    }
    
    private func gridColumns(for width: CGFloat) -> [GridItem] {
        let columnCount = numberOfColumns(for: width)
        
        return Array(repeating: GridItem(.adaptive(minimum: cellMinSize), spacing: 1), count: columnCount)
    }
    
    private func numberOfColumns(for width: CGFloat) -> Int {
        let minCellSize: CGFloat = 150
        
        let availableWidth = width
        let columnCount = max(2, Int(availableWidth / minCellSize))
        
        return columnCount
    }

}

struct ImageView<Placeholder: View>: View {
    
    let imageSource: ImageSource
    let placeholder: () -> Placeholder
    
    var body: some View {
        switch imageSource {
        case .url(let url):
            CacheAsyncImage(placeholder: placeholder, url: url)
        case .image(let image):
            image
                .resizable()
        }
    }
    
}
