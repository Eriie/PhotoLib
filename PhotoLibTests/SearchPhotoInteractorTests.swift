import Foundation
import Testing
@testable import PhotoLib

@MainActor
struct SearchPhotoInteractorTests {

    @Test
    func search_withEmptyQuery_throws() async {
        let sut = SearchPhotoInteractor(dataSource: StubDataSource())
        await #expect(throws: PhotoLibInteractorError.emptySearchString, performing: {
            _ = try await sut.search(query: "   ")
        })
    }

    @Test
    func search_and_loadMore_updatesPages() async throws {
        let sut = SearchPhotoInteractor(dataSource: StubDataSource())
        let first = try await sut.search(query: "cat")
        #expect(first.count == 2)
        let more = try await sut.loadMore()
        #expect(more.count == 2)
        let end = try await sut.loadMore()
        #expect(end.isEmpty)
    }
}

private final class StubDataSource: SearchPhotoDataSource {
    private var pageCallCount = 0
    
    func searchPhotos(query: String, page: Int) async throws -> SearchPhotoResult {
        pageCallCount += 1
        switch page {
        case 1:
            return SearchPhotoResult(nextPage: 2, photos: [
                .init(id: 1, previewImage: .url(URL(string: "https://example.com/1t")!), fullImage: .url(URL(string: "https://example.com/1p")!), avgColor: .gray),
                .init(id: 2, previewImage: .url(URL(string: "https://example.com/2t")!), fullImage: .url(URL(string: "https://example.com/2p")!), avgColor: .gray)
            ])
        case 2:
            return SearchPhotoResult(nextPage: nil, photos: [
                .init(id: 3, previewImage: .url(URL(string: "https://example.com/3t")!), fullImage: .url(URL(string: "https://example.com/3p")!), avgColor: .gray),
                .init(id: 4, previewImage: .url(URL(string: "https://example.com/4t")!), fullImage: .url(URL(string: "https://example.com/4p")!), avgColor: .gray)
            ])
        default:
            return SearchPhotoResult(nextPage: nil, photos: [])
        }
    }
}
