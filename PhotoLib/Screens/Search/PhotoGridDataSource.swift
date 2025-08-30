import Foundation

struct PhotoSearchResult {
    let page: Int
    let photos: [Photo]
    let hasMore: Bool
}

protocol PhotoGridDataSource {
    func searchPhotos(query: String, page: Int) async throws -> PhotoSearchResult
}
