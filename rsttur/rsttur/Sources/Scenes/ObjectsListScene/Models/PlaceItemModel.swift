import Foundation

// MARK: - Place item model

struct PlaceItemModel: Identifiable {
    let id: Int
    let type: String
    let name: String
    let description: String
    var imageData = Data()
}
