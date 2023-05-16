import Foundation

// MARK: - RSTTUR response contaner

struct BackendResponseContainer<CustomData: Decodable>: Decodable {
    let data: CustomData
}

// MARK: - Response data model

struct ResponseDataModel: Decodable {
    let geo: NavigationPointModel
    let categories: [CategoryDataModel]
    let objects: [PlaceDataModel]
}

// MARK: - Navigation point model

struct NavigationPointModel: Decodable {
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

// MARK: - Category model

struct CategoryDataModel: Decodable {
    let name: String
    let type: String
    let icon: String
    let color: String
    let count: Int
}

// MARK: - Object model, also appeared in PlaceItemView

struct PlaceDataModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let image: String
    let type: String
    let close: Bool
    let icon: String
    let color: String
    let lat: Double
    let lon: Double
    let working_hours: [WorkingHoursDataModel]?
}

// MARK: - Working hours model

struct WorkingHoursDataModel: Decodable {
    let days: [Int]
    let from: String
    let to: String
}
