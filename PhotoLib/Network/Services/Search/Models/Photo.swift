import Foundation

struct Photo: Codable {
    let id: Int
    let width: Int
    let height: Int
    let url: URL
    let photographer: String
    let photographerUrl: URL
    let photographerId: Int
    let avgColor: String
    let src: PhotoSource
    let liked: Bool
    let alt: String
}

struct PhotoSource: Codable {
    let original: URL
    let small: URL
    let tiny: URL
}
