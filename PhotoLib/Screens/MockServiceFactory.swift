import Foundation
import UIKit
import SwiftUI

final class MockServiceFactory: ObservableObject {

    private(set) lazy var searchDataSource: SearchPhotoDataSource = {
        MockSearchPhotoDataSource()
    }()

}

private class MockSearchPhotoDataSource: SearchPhotoDataSource {

    func searchPhotos(query: String, page: Int) async throws -> SearchPhotoResult {
        
        let mockPhotos = [
            SearchPhotoResult.PhotoViewModel(
                id: 2,
                previewImage: .image(.colorImage( .cyan)),
                fullImage: .image(.colorImage( .blue)),
                avgColor: .white
            )
        ]

        return SearchPhotoResult(
            page: page,
            photos: mockPhotos,
            hasMore: page < 3 // Simulate having more pages for pagination
        )
    }
}

extension UIImage {
    static func onePixelImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

extension Image {
    static func colorImage(_ color: UIColor) -> Image {
        Image(uiImage: .onePixelImage(color: color))
    }
}

