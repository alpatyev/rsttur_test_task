import SwiftUI

// MARK: - Init linear gradient from model / colors with angle

extension LinearGradient {
    init(startColor: Color, endColor: Color, angle: Double) {
        let gradient = Gradient(colors: [startColor, endColor])
        
        let startPoint = UnitPoint(x: CGFloat(cos(angle * .pi / 180)),
                                   y: CGFloat(sin(angle * .pi / 180)))
        let endPoint = UnitPoint(x: CGFloat(cos((angle + 180) * .pi / 180)),
                                 y: CGFloat(sin((angle + 180) * .pi / 180)))
        
        self.init(gradient: gradient,
                  startPoint: startPoint,
                  endPoint: endPoint)
    }
    
    init(model: LinearGradientModel) {
        self.init(startColor: Color(hex: model.startColorHex, alpha: model.startColorAlpha),
                  endColor: Color(hex: model.endColorHex, alpha: model.endColorAlpha),
                  angle: model.angle)
    }
}
