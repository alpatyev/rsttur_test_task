import SwiftUI

// MARK: - Category main view

struct CategoriesMainView: View {
    
    @StateObject var viewModel: CategoriesViewModel
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(viewModel.categoriesList) { category in
                    NavigationLink(destination: {
                        PlacesListView(selectedCategory: category.type, viewModel: viewModel)
                    }) {
                        CategoryItemView(model: category)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Категории")
            .onAppear {
                viewModel.categoriesListAppeared()
            }
        }
        .navigationViewStyle(.stack)
        .overlay(
            Group {
                if viewModel.detailPlaceState {
                    DetailPlaceView(viewModel: viewModel)
                }
            }
        )
    }
}
