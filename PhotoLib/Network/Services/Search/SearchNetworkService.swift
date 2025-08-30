import Foundation

struct PhotoService {
    
    init(client: PexelsClient) {
        self.client = client
    }

    func search(query: String, page: Int = 1, perPage: Int = 20) async throws -> PhotoSearchResponse {
        let queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage))
        ]
        return try await client.performRequest(path: "search", queryItems: queryItems)
    }
    
    private let client: PexelsClient
}
