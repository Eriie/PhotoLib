import Foundation

final class SearchPhotoDataSourceImpl: SearchPhotoDataSource {
    private let photoService: PhotoService

    init(photoService: PhotoService) {
        self.photoService = photoService
    }

    func searchPhotos(query: String, page: Int) async throws -> SearchPhotoResult {
        let response = try await photoService.search(query: query, page: page)
        let hasMore = response.nextPage != nil
        return SearchPhotoResult(page: response.page, photos: response.photos, hasMore: hasMore)
    }
}
