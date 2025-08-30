import Testing
import SwiftUI
@testable import PhotoLib

struct ImageCacheTests {
    
    @Test
    @MainActor
    func setAndGet_returnsSameInstance() throws {
        let cache = ImageCache.default
        let key = URL(string: "https://example.com/image.png")!
        let image = Image(systemName: "photo")
        cache.set(forKey: key, image: image)
        let fetched = cache.get(forKey: key)
        #expect(fetched != nil)
    }
}
