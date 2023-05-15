import SwiftUI

// MARK: - Places list main view

struct PlacesListView: View {
    
    let selectedCategory: String
    @ObservedObject var viewModel: CategoriesViewModel
    
    var body: some View {
        List() {
            ForEach(viewModel.specificCategoryPlacesList) { place in
                Button {
                    viewModel.placeSelected(with: place.id)
                } label: {
                    PlacesItemView(model: place)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Oбъекты")
        .onAppear {
            viewModel.selectedCategoryAppeared(with: selectedCategory)
        }
    }
}
