import Foundation
import SwiftUI

struct ImageView<Placeholder: View>: View {
    
    let imageSource: ImageSource
    let placeholder: () -> Placeholder
    
    var body: some View {
        switch imageSource {
        case .url(let url):
            CacheAsyncImage(placeholder: placeholder, url: url)
        case .image(let image):
            image
                .resizable()
        }
    }
    
}
