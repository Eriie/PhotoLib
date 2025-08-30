import Foundation

struct PhotoSearchResponse: Codable {
    let totalResults: Int
    let page: Int
    let perPage: Int
    let photos: [Photo]
    let nextPage: String?
}
