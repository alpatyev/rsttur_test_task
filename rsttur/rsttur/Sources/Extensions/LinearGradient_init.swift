import SwiftUI

// MARK: - Init linear gradient from two colors and angle

extension LinearGradient {
    init(startColor: Color, endColor: Color, angle: Double) {
        let gradient = Gradient(colors: [startColor, endColor])
        let startPoint = UnitPoint(x: CGFloat(cos(angle * .pi / 180)), y: CGFloat(sin(angle * .pi / 180)))
        let endPoint = UnitPoint(x: CGFloat(cos((angle + 180) * .pi / 180)), y: CGFloat(sin((angle + 180) * .pi / 180)))
        self.init(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
    }
}
