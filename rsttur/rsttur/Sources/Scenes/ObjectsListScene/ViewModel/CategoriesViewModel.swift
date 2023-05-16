import Foundation
import Combine

// MARK: - Categories viewmodel

final class CategoriesViewModel: ObservableObject {
    
    @Published var detailPlaceState = false
    @Published var categoriesList = [CategoryItemModel]()
    @Published var placesList = [PlaceDataModel]()
    @Published var specificCategoryPlacesList = [PlaceDataModel]()
    @Published var selectedPlace = PlaceDataModel()
    @Published var imageBuffer = [Int: Data]()

    private let deeplinkService: DeeplinkServiceProtocol
    private let networkService: BackendNetworkServiceProtocol
    private let cacheService: DataCashingServiceProtocol
    private let cancellables = Set<AnyCancellable>()
    private var viewDidLoaded = false
    
    init() {
        deeplinkService = DeeplinkService()
        networkService = BackendNetworkService()
        cacheService = DataCashingService()
    }
    
    func categoriesListAppeared() {
        if viewDidLoaded {
            imageBuffer.removeAll()
            specificCategoryPlacesList.removeAll()
            networkService.interruptAllTasks()
        } else {
            viewDidLoaded = true
            initialFetchRequest()
        }
    }
    
    func selectedCategoryAppeared(with name: String) {
        DispatchQueue.main.async { [weak self] in
            self?.specificCategoryPlacesList = self?.placesList.filter { $0.type == name } ?? []
            self?.downloadImagesForSelectedCategory()
        }
    }
    
    func detailPlaceViewAppeared() {
        let id = selectedPlace.id
        let url = selectedPlace.image
        
        if let cachedData = cacheService.getCachedImageData(with: id, from: .fullSized) {
            imageBuffer[id] = cachedData
        } else {
            networkService.fetchImageData(id: id, url: url) { [weak self] id, data in
                DispatchQueue.main.async {
                    if let downloadedData = data {
                        self?.imageBuffer[id] = downloadedData
                        self?.cacheService.cacheImage(.fullSized, data: downloadedData, with: id)
                    }
                }
            }
        }
    }
    
    func placeSelected(with id: Int) {
        if let detailPlace = placesList.first(where: { $0.id == id }) {
            selectedPlace = detailPlace
            detailPlaceState = true
        }
    }
    
    func detailPlaceViewTapped() {
        detailPlaceState = false
    }
    
    func navigatorButtonTapped() {
        let endPoint = NavigationPointModel(longitude: selectedPlace.lon, latitude: selectedPlace.lat)
        deeplinkService.twoGisDeeplink(to: endPoint)
    }
    
    private func initialFetchRequest() {
        networkService.fetchRequest(requestType: .objectsList) { [weak self] (model: ResponseDataModel?, _) in
            if let result = model {
                self?.updateCategories(from: result.categories)
                self?.updatePlaces(from: result.objects)
                self?.deeplinkService.setupNewCoordinate(from: result.geo)
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
    
    private func downloadImagesForSelectedCategory() {
        for place in specificCategoryPlacesList {
            DispatchQueue.main.async { [weak self] in
                self?.checkCacheAndUpload(using: place)
            }
        }
    }
    
    private func checkCacheAndUpload(using place: PlaceDataModel) {
        if let cachedData = cacheService.getCachedImageData(with: place.id, from: .tableSize) {
            DispatchQueue.main.async(qos: .utility) { [weak self] in
                self?.imageBuffer[place.id] = cachedData
            }
        } else {
            networkService.fetchImageData(id: place.id, url: place.image) { [weak self] id, data in
                DispatchQueue.main.async(qos: .userInitiated) { [weak self] in
                    if let downloadedData = data {
                        self?.imageBuffer[id] = downloadedData.compressedAsImage(0.1)
                        self?.cacheService.cacheImage(.tableSize, data: downloadedData, with: id)
                    }
                }
            }
        }
    }
}
