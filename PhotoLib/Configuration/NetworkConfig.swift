import Foundation

struct NetworkConfig {
    let apiKey: String
    let pexelBaseURL: URL
}


static let defaultNetworkConfig = NetworkConfig(
    apiKey: "YOUR_API_KEY",
    pexelBaseURL: URL(string: "https://api.pexels.com/v1/")!
)