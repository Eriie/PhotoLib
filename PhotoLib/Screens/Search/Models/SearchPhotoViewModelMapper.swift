import Foundation

struct SearchPhotoViewModelMapper {
    static func map(photos: [Photo]) -> [SearchPhotoItemViewModel] {
        photos.map { photo in
            SearchPhotoItemViewModel(
                id: photo.id,
                previewUrl: photo.src.small,
                original: photo.src.original
            )
        }
    }
}
