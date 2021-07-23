import Kingfisher
import SwiftUI

extension KFImage {
    func header() -> some View {
        GeometryReader { geometry in
            resizable()
                .placeholder {
                    ProgressView()
                        .frame(height: 240)
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: 240)
                .clipped()
        }
        .frame(height: 240)
    }
}
