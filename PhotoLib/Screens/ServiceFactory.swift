import Foundation
import SwiftUI

final class ServiceFactory: ObservableObject {
    private(set) lazy var pexelsClient = PexelsClient(config: .default)
    private(set) lazy var searchPhotoService: SearchNetworkService = {
        SearchNetworkService(client: pexelsClient)
    }()
    private(set) lazy var searchDataSource: SearchPhotoDataSource = {
        SearchPhotoDataSourceImpl(photoService: searchPhotoService)
    }()
}
