import Foundation

protocol NetworkClient {
    func performRequest<T: Decodable>(path: String, queryItems: [URLQueryItem]) async throws -> T
}

extension NetworkClient {
    func performRequest<T: Decodable>(path: String) async throws -> T {
        return try await performRequest(path: path, queryItems: [])
    }
}
