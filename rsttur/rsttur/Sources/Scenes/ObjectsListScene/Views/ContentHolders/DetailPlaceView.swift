import SwiftUI

// MARK: - Detail place view

struct DetailPlaceView: View {
    
    @ObservedObject var viewModel: CategoriesViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack {
                    Text(viewModel.selectedPlace.name)
                        .font(.largeTitle)
                        .foregroundColor(Color(hex: Env_Colors_Dictionary.colors[viewModel.selectedPlace.color]))
                        .padding(10)
                }
                .padding(.top, 80)
                .padding(.horizontal, 20)
                
                SafePlaceImageView(imageData: viewModel.imageBuffer[viewModel.selectedPlace.id] ?? Data())
                    .aspectRatio(1.5, contentMode: .fit)
                    .padding(.horizontal, 40)
                    .shadow(color: .gray, radius: 16, x: 4, y: 8)

                
               
                Text(viewModel.selectedPlace.description)
                    .font(.title3)
                    .cornerRadius(16)
                    .padding(.horizontal, 30)

                VStack {
                    HStack {
                        Spacer()
                        
                        Text("Часы работы:")
                            .font(.title2)
                            .padding(10)
                        
                        Spacer()
                        
                        if !viewModel.selectedPlace.close {
                            Text("закрыто")
                                .font(.title2)
                                .foregroundColor(.red)
                                .cornerRadius(8)
                                .padding(10)
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        if let availableDays = viewModel.selectedPlace.working_hours {
                            WorkingDaysView(workingHoursModels: availableDays.map { $0.convertedToItem() })
                                .padding(20)
                        }
                    }
                }
                .background(Env_Gradients.g07.linearGradient())
                .cornerRadius(16)
                .padding(20)
                
                Button(action: {
                    viewModel.navigatorButtonTapped()
                }, label: {
                    Text("Построить маршрут в 2ГИС")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(16)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 20)
                })
                
                Spacer()
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            viewModel.detailPlaceViewTapped()
        }
        .onAppear {
            viewModel.detailPlaceViewAppeared()
        }
    }
}


