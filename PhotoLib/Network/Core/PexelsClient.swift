import Foundation

class PexelsClient {

    // MARK: - Initialization

    init(
        config: NetworkConfig,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.config = config
        self.decoder = decoder
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // MARK: - Public

    func performRequest<T: Decodable>(path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        guard var components = URLComponents(url: config.pexelBaseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        components.queryItems = queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.setValue(config.apiKey, forHTTPHeaderField: "Authorization")

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        if let httpErrorType = getStatusCodeErrorType(from: httpResponse.statusCode) {
            throw NetworkError.httpError(httpResponse.statusCode, httpErrorType)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    // MARK: - Private
    
    private let session: URLSession
    private let config: NetworkConfig
    
    private let decoder: JSONDecoder

    private func getStatusCodeErrorType(from code: Int) -> HTTPErrorType? {
        switch code {
            case 400..<500:
                .clientError
            case 500..<600:
                .serverError
        default:
            nil
            
        }
    }
}

extension PexelsClient {
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case httpError(Int, HTTPErrorType)
        case decodingError(Error)
    }

    enum HTTPErrorType: Error {
        case clientError
        case serverError
    }
}



