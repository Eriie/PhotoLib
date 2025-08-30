import Foundation
import SwiftUI

struct SearchPhotoItemViewModel: Identifiable, Equatable {
    let id: Int
    let previewUrl: ImageSource
    let original: ImageSource
    let avgColor: Color
}
