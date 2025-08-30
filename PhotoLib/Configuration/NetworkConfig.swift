import Foundation

struct NetworkConfig {
    let apiKey: String
    let pexelBaseURL: URL
}


extension NetworkConfig {
    static let `default` = NetworkConfig(
        apiKey: "YOUR_API_KEY",
        pexelBaseURL: URL(string: "https://api.pexels.com/v1/")!
    )
}
