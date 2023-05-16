import SwiftUI

// MARK: - Init Color from rgba value UInt32

extension Color {
    init(rgba: UInt32) {
        let red = Double((rgba >> 24) & 0xFF) / 255.0
        let green = Double((rgba >> 16) & 0xFF) / 255.0
        let blue = Double((rgba >> 8) & 0xFF) / 255.0
        let alpha = Double(rgba & 0xFF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
