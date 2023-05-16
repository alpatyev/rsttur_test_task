import SwiftUI

// MARK: - Entry point

@main
struct rstturApp: App {
    var body: some Scene {
        WindowGroup {
            CategoriesMainView(viewModel: CategoriesViewModel())
        }
    }
}
