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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140, maximum: 200), spacing: 1)], spacing: 1) {
            ForEach(photos) { photo in
                Button(action: {

                }) {
                    ImageView(imageSource: photo.previewUrl, placeholder: {
                        photo.avgColor
                            .scaledToFill()
                    })
                    .aspectRatio(contentMode: .fill)
                    .frame(minHeight: 140)
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
