import Foundation

final class SearchPhotoDataSourceImpl: SearchPhotoDataSource {
    private let photoService: SearchNetworkService

    init(photoService: SearchNetworkService) {
        self.photoService = photoService
    }

    func searchPhotos(query: String, page: Int) async throws -> SearchPhotoResult {
        let response = try await photoService.search(query: query, page: page)
        let hasMore = response.nextPage != nil
        return SearchPhotoResult(
            nextPage: hasMore ? page + 1 : nil,
            photos: response.photos.map { SearchPhotoResult.PhotoModel(photo: $0) }
        )
    }
}
