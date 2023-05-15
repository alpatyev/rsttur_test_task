import SwiftUI

// MARK: - Places item view

struct PlacesItemView: View {
    
    let model: PlaceDataModel
    
    var body: some View {
        HStack {
            SafePlaceImageView(imageData: model.imageData ?? Data())
                .frame(width: 120, height: 90)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(model.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(model.description)
                    .font(.body)
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
            .padding(.vertical, 4)
        }
        .frame(height: 100)
    }
}
