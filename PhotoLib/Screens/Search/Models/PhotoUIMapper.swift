import Foundation

struct PhotoUIMapper {
    static func map(photos: [Photo]) -> [PhotoUIModel] {
        photos.map { photo in
            PhotoUIModel(
                id: photo.id,
                previewUrl: photo.src.small,
                orginal: photo.src.original
            )
        }
    }
}
