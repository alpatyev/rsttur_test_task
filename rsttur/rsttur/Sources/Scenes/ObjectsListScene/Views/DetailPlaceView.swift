import SwiftUI

// MARK: - Detail place view

struct DetailPlaceView: View {
    
    @Binding var model: PlaceDataModel
    
    var body: some View {
        VStack {
            Text(model.name)

            Spacer()
            
            HStack {
                
                Spacer()
            }
        }
        .background(Env_Gradients.g11.linearGradient())
    }
}
