import SwiftUI

extension SearchPhotoResult.PhotoModel {
    init(photo: Photo) {
        self.id = photo.id
        self.previewImage = .url(photo.src.tiny)
        self.fullImage = .url(photo.src.portrait)
        self.avgColor = Color(hex: photo.avgColor) ?? .clear
    }
}


extension Color {
    init?(hex: String) {
        var str = hex
        if str.hasPrefix("#") {
            str.removeFirst()
        }

        if ![2, 3, 4, 6, 8].contains(str.count) { return nil }
        
        guard let color = UInt64(str, radix: 16) else { return nil }
        
        switch str.count {
        case 2:
            let gray = Double(Int(color) & 0xFF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
        case 4:
            let gray = Double(Int(color >> 8) & 0xFF) / 255
            let alpha = Double(Int(color) & 0xFF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
        case 3:
            // Shorthand #RGB format
            let r = Double((color >> 8) & 0xF) / 15
            let g = Double((color >> 4) & 0xF) / 15
            let b = Double(color & 0xF) / 15
            self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
        case 6:
            let r = Double((color >> 16) & 0xFF) / 255
            let g = Double((color >> 8) & 0xFF) / 255
            let b = Double(color & 0xFF) / 255
            self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
        case 8:
            let r = Double((color >> 24) & 0xFF) / 255
            let g = Double((color >> 16) & 0xFF) / 255
            let b = Double((color >> 8) & 0xFF) / 255
            let a = Double(color & 0xFF) / 255
            self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
        default:
            return nil
        }
    }
}
