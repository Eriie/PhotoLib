import SwiftUI
import UIKit

@MainActor
final class ImageCache {
    static let `default` = ImageCache()

    private init() {}

    func get(forKey key: URL) -> Image? {
        return cache.object(forKey: key as NSURL)?.image
    }

    func set(forKey key: URL, image: Image) {
        cache.setObject(ImageWrapper(image), forKey: key as NSURL)
    }

    private let cache = NSCache<NSURL, ImageWrapper>()
}

private final class ImageWrapper {
    let image: Image
    
    init(_ image: Image) {
        self.image = image
    }
}
