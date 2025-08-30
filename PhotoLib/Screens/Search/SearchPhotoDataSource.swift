import Foundation

struct SearchPhotoResult {
    let page: Int
    let photos: [Photo]
    let hasMore: Bool
}

protocol SearchPhotoDataSource {
    func searchPhotos(query: String, page: Int) async throws -> SearchPhotoResult
}

extension SearchPhotoDataSource {
    func searchPhotos(query: String) async throws -> SearchPhotoResult {
        try await searchPhotos(query: query, page: 1)
    }
}
