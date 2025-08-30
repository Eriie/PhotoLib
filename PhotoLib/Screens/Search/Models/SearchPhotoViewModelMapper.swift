import Foundation

extension SearchPhotoItemViewModel {
    init(photoModel: SearchPhotoResult.PhotoModel) {
        self.id = photoModel.id
        self.previewUrl = photoModel.previewImage
        self.original = photoModel.fullImage
        self.avgColor = photoModel.avgColor
    }
    
}
