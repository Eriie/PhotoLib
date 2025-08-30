import Foundation

struct NetworkConfig {
    let apiKey: String
    let pexelBaseURL: URL
}


extension NetworkConfig {
    static let `default` = NetworkConfig(
        apiKey: "GJsbIg7CIMqjgk9v1SCHDsNEH01cwiOw8XSCdBfQdViCqeXrIWOP4WBF",
        pexelBaseURL: URL(string: "https://api.pexels.com/v1/")!
    )
}
