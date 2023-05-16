import SwiftUI

// MARK: - Working hours items model

struct WorkingHoursItemModel: Identifiable, Hashable {
    let id = UUID()
    let days: [String]
    let available: String
}
