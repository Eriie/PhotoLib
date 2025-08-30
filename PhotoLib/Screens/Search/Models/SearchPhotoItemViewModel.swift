import Foundation

struct SearchPhotoItemViewModel: Identifiable, Equatable {
    let id: Int
    let previewUrl: URL
    let original: URL
}
