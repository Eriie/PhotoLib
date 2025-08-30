import Foundation
import SwiftUI

struct SearchPhotoResult {
    let page: Int
    let photos: [PhotoViewModel]
    let hasMore: Bool

    struct PhotoViewModel {
        let id: Int
        let previewImage: ImageSource
        let fullImage: ImageSource
        let avgColor: Color
    }
}

enum ImageSource {
    case url(URL)
    case image(Image)
}

protocol SearchPhotoDataSource {
    func searchPhotos(query: String, page: Int) async throws -> SearchPhotoResult
}

extension SearchPhotoDataSource {
    func searchPhotos(query: String) async throws -> SearchPhotoResult {
        try await searchPhotos(query: query, page: 1)
    }
}
