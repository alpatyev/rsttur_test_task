import SwiftUI

// MARK: - Category main view

struct CategoriesMainView: View {
    
    @ObservedObject var viewModel: CategoriesViewModel
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(viewModel.categories) { category in
                    NavigationLink(destination: {
                        Text(category.categoryName)
                    }) {
                        CategoryItemView(model: category)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Категории")
        }
        .navigationViewStyle(.stack)
    }
}
