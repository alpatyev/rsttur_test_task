import Foundation
import Combine

// MARK: - Categories viewmodel

final class CategoriesViewModel: ObservableObject {
    
    @Published var categoriesList = [CategoryItemModel]()
    @Published var placesList = [PlaceDataModel]()
    @Published var specificCategoryPlacesList = [PlaceDataModel]()
    
    private var networkService: BackendNetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        networkService = BackendNetworkService()
        
        initialFetchRequest()
    }
    
    func categoriesListAppeared() {
        specificCategoryPlacesList.removeAll()
    }
    
    func selectedCategoryAppeared(with name: String) {
        DispatchQueue.main.async {
            self.specificCategoryPlacesList = self.placesList.filter { $0.type == name }
        }
    }
    
    private func initialFetchRequest() {
        networkService.fetchRequest(requestType: .objectsList) { [weak self] (model: ResponseDataModel?, _) in
            if let result = model {
                self?.updateCategories(from: result.categories)
                self?.updatePlaces(from: result.objects)
            }
        }
    }
    
    private func updateCategories(from results: [CategoryDataModel]) {
        guard !results.isEmpty else { return }
                
        DispatchQueue.main.async { [weak self] in
            self?.categoriesList = results.compactMap { self?.convertServerModelToCategory($0) }
        }
    }
    
    private func updatePlaces(from results: [PlaceDataModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.placesList = results
        }
    }
    
    private func convertServerModelToCategory(_ model: CategoryDataModel) -> CategoryItemModel? {
        CategoryItemModel(type: model.type,
                          categoryName: model.name,
                          count: model.count,
                          countCircleColor: model.color)
    }

}
