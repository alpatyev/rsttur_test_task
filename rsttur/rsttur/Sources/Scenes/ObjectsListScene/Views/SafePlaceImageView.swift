import SwiftUI

// MARK: - Safe place image view

struct SafePlaceImageView: View {
    
    let imageData: Data
    
    var body: some View {
        ZStack {
            Color(rgba: Env_Colors.gray08.rgbaValue)
            
            if let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .cornerRadius(16)
    }
}

