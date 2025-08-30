import Foundation
import SwiftUI

struct PhotoDetailsView: View {
    let photo: SearchPhotoItemViewModel
    
    @Environment(\.dismiss) private var dismiss
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var isZoomed = false
    
    var body: some View {
        VStack { 
            ImageView(imageSource: photo.original, placeholder: {
                photo.avgColor.scaledToFill()
            })
            .scaledToFit()
            .scaleEffect(scale)
            .offset(offset)
            .gesture(
                SimultaneousGesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = value
                        }
                        .onEnded { value in
                            if scale < 1 {
                                withAnimation(.spring()) {
                                    scale = 1
                                    offset = .zero
                                }
                            } else if scale > 3 {
                                withAnimation(.spring()) {
                                    scale = 3
                                }
                            }
                            isZoomed = scale > 1
                        },
                    
                    DragGesture()
                        .onChanged { value in
                            if isZoomed {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            if !isZoomed {
                                withAnimation(.spring()) {
                                    offset = .zero
                                }
                            }
                        }
                )
            )
            .onTapGesture(count: 2) {
                withAnimation(.spring()) {
                    if scale > 1 {
                        scale = 1
                        offset = .zero
                        isZoomed = false
                    } else {
                        scale = 2
                        isZoomed = true
                    }
                }
            }
        }
    }
}
