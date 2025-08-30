import Foundation
import SwiftUI

struct SearchPhotoResult {
    let nextPage: Int?
    let photos: [PhotoModel]

    struct PhotoModel {
        let id: Int
        let previewImage: ImageSource
        let fullImage: ImageSource
        let avgColor: Color
    }
}

enum ImageSource: Equatable {
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
