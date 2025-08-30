import Foundation
import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    
    var scale: CGFloat = 0.9
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
