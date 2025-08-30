import Foundation

struct NetworkConfig {
    let apiKey: String
    let pexelBaseURL: URL
}


extension NetworkConfig {
    static let `default` = NetworkConfig(
        apiKey: "",
        pexelBaseURL: URL(string: "https://api.pexels.com/v1/")!
    )
}
