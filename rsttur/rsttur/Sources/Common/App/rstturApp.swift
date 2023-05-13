import SwiftUI

// MARK: - Entry point

@main
struct rstturApp: App {
    var body: some Scene {
        WindowGroup {
            GradientView(startColor: .blue, endColor: .red, angle: .degrees(145))
        }
    }
}
