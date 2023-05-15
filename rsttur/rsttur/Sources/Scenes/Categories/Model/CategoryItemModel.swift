import Foundation

// MARK: - Category item model

struct CategoryItemModel: Identifiable {
    let id = UUID()
    let categoryName: String
    let count: Int
    let countCircleColor: String
}
