import SwiftUI

struct CacheAsyncImage<PlacheHolder: View>: View {
    let placheholder: () -> PlacheHolder
    let url: URL
    var cacheStorage: ImageCache = .default

    var body: some View {
        if let cachedImage = cacheStorage.get(forKey: url) {
            cachedImage
                .resizable()
                .scaledToFit()
        } else {
            AsyncImage(url: url) { phase in
                handlePhase(phase)
            }
        }
    }
    
    @ViewBuilder
    private func handlePhase(_ phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            placheholder()
        case .success(let image):
            let _ = cacheStorage.set(forKey: url, image: image)
            image
                .resizable()
                .scaledToFit()
        case .failure:
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
        @unknown default:
            EmptyView()
        }
    }
}
