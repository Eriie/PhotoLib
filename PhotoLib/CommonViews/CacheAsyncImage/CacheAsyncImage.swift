import SwiftUI

struct CacheAsyncImage<PlacheHolder: View>: View {
    let placeholder: () -> PlacheHolder
    let url: URL
    var cacheStorage: ImageCache = .default

    var body: some View {
        if let cachedImage = cacheStorage.get(forKey: url) {
            cachedImage
                .resizable()
        } else {
            AsyncImage(url: url, transaction: .init(animation: .easeInOut)) { phase in
                handlePhase(phase)
            }
        }
    }
    
    @ViewBuilder
    private func handlePhase(_ phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            placeholder()
        case .success(let image):
            let _ = cacheStorage.set(forKey: url, image: image)
            image
                .resizable()
                .transition(.opacity)
        case .failure:
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
                .transition(.opacity)
        @unknown default:
            EmptyView()
        }
    }
}
