import SwiftUI

struct GradientView: View {
    
    let startColor: Color
    let endColor: Color
    let angle: Angle

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [startColor, endColor]),
            startPoint: startPoint(for: angle),
            endPoint: endPoint(for: angle))
    }

    private func startPoint(for angle: Angle) -> UnitPoint {
        let x = cos(angle.radians)
        let y = sin(angle.radians)
        return UnitPoint(x: CGFloat(x), y: CGFloat(y))
    }

    private func endPoint(for angle: Angle) -> UnitPoint {
        let x = cos((angle + Angle(degrees: 180)).radians)
        let y = sin((angle + Angle(degrees: 180)).radians)
        return UnitPoint(x: CGFloat(x), y: CGFloat(y))
    }
}
