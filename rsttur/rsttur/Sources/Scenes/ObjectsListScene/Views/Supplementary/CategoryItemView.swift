import SwiftUI

// MARK: - Category item view

struct CategoryItemView: View {
    
    let model: CategoryItemModel

    var body: some View {
        HStack {
            Text(model.categoryName)
                .foregroundColor(.black)
                .font(.title3)
            
            Spacer()
            
            ZStack {
                Circle()
                    .foregroundColor(Color(hex: Env_Colors_Dictionary.colors[model.countCircleColor]))
                    .frame(width: 30, height: 30)
                
                Text("\(model.count)")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
    
}
