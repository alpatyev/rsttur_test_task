import SwiftUI

// MARK: - Category item view

struct CategoryItemView: View {
    
    let model: CategoryItemModel

    var body: some View {
        HStack {
            Text(model.categoryName)
            
            Spacer()
            
            ZStack {
                Circle()
                    .foregroundColor(Color(rgba: Env_Colors.cyan03.rgbaValue))
                    .frame(width: 30, height: 30)
                Text("\(model.count)")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
}
