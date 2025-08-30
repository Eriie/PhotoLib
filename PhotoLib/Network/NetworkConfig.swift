import Foundation

struct NetworkConfig {
    let apiKey: String
    let pexelBaseURL: URL
}


extension NetworkConfig {
    static let `default` = NetworkConfig(
        apiKey: "", // TODO: API キーを追加してください
        pexelBaseURL: URL(string: "https://api.pexels.com/v1/")!
    )
}
