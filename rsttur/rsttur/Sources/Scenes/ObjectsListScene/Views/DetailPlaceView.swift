import SwiftUI

// MARK: - Detail place view

struct DetailPlaceView: View {
    
    @ObservedObject var viewModel: CategoriesViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.selectedPlace.name)
                .font(.largeTitle)
                .foregroundColor(Color(hex: viewModel.selectedPlace.color))
                .padding(.bottom, 20)
            
            SafePlaceImageView(imageData: viewModel.imageBuffer[viewModel.selectedPlace.id] ?? Data())
                .aspectRatio(1.5, contentMode: .fit)
                .padding(40)

            
            HStack {
                Spacer()
            }
            
            Spacer()
        }
        .background(Env_Gradients.g11.linearGradient())
        .edgesIgnoringSafeArea(.all)
        .padding(.top, 200)
        .onTapGesture {
            viewModel.detailPlaceViewTapped()
        }
        .onAppear {
            viewModel.detailPlaceViewAppeared()
        }
    }
}
