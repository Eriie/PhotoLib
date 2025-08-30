import Foundation

enum PhotoLibInteractorError: Error {
    case emptySearchString
}

@MainActor
class PhotoGridInteractor {
    private let dataSource: PhotoGridDataSource
    private var nextPage: Int?
    private var currentQuery = ""

    init(dataSource: PhotoGridDataSource) {
        self.dataSource = dataSource
    }

    func search(query: String) async throws -> [Photo] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { throw PhotoLibInteractorError.emptySearchString }
        currentQuery = query

        let result = try await dataSource.searchPhotos(query: query, page: 1)
        try Task.checkCancellation()
        nextPage = result.hasMore ? result.page + 1 : nil
        return result.photos
    }

    func loadMore() async throws -> [Photo] {
        guard let nextPage else { return [] }

        let result = try await dataSource.searchPhotos(query: currentQuery, page: nextPage)
        try Task.checkCancellation()
        self.nextPage = result.hasMore ? result.page + 1 : nil
        return result.photos
    }
}
