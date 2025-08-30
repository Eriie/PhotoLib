import SwiftUI
import UIKit

@MainActor
final class ImageCache {
    static let `default` = ImageCache()

    private init() {}

    func get(forKey key: URL) -> UIImage? {
        return cache.object(forKey: key as NSURL)
    }

    func set(forKey key: URL, image: Image) {
        guard let uiImage = image.asUIImage() else {
            return
        }
        cache.setObject(uiImage, forKey: key as NSURL)
    }

    private let cache = NSCache<NSURL, UIImage>()
}

extension Image {
    
    @MainActor
    fileprivate func asUIImage() -> UIImage? {
        ImageRenderer(content: self).uiImage
    }
}
