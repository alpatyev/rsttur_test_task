import Foundation
import Combine

// MARK: - Categories viewmodel

final class CategoriesViewModel: ObservableObject {
    
    @Published var categories = [CategoryItemModel]()
    
    private var networkService: BackendNetworkServiceProtocol
    
    init() {
        networkService = BackendNetworkService()
        
        networkService.fetchRequest(requestType: .objectsList) { [weak self] (model: ResponseDataModel?, _) in
            if let result = model {
                self?.updateCategories(from: result.categories)
                result.categories.forEach { print($0.color )}
            }
        }
    }
    
    private func updateCategories(from results: [CategoryDataModel]) {
        guard !results.isEmpty else { return }
                
        DispatchQueue.main.async { [weak self] in
            self?.categories = results.compactMap { self?.convertServerModelToCategory($0) }
        }
    }
    
    private func convertServerModelToCategory(_ model: CategoryDataModel) -> CategoryItemModel? {
        CategoryItemModel(categoryName: model.name,
                          count: model.count,
                          countCircleColor: model.color)
    }
}
