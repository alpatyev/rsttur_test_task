import SwiftUI

// MARK: - Detail place view

struct DetailPlaceView: View {
    
    @ObservedObject var viewModel: CategoriesViewModel
    
    var body: some View {
        VStack {
            SafePlaceImageView(imageData: viewModel.imageBuffer[viewModel.selectedPlace.id] ?? Data())
                .aspectRatio(1.5, contentMode: .fit)
                .padding(40)

            
            HStack {
                Spacer()
            }
            
            Spacer()
        }
        .background(Env_Gradients.g11.linearGradient())
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
            viewModel.detailPlaceViewTapped()
        }
        .onAppear {
            viewModel.detailPlaceViewAppeared()
        }
    }
}
