import Foundation
import SwiftUI

final class ServiceFactory: ObservableObject {
    
    private(set) lazy var pexelCliens = PexelsClient(config: .default)
    
    private(set) lazy var searchPhostoService: SearchNetworkService = {
        SearchNetworkService(client: pexelCliens)
    }()
    
    private(set) lazy var searchDataSource: SearchPhotoDataSource = {
        SearchPhotoDataSourceImpl(photoService: searchPhostoService)
    }()

}
