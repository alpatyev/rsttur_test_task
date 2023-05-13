import SwiftUI

// MARK: - Dictionary which casted to linear gradient parameters

extension Dictionary where Key == String, Value == Any {
    func linearGradient() -> LinearGradient {
        if let angleString = self["angle"] as? String,
           let startColorHex = self["startColor"] as? String,
           let startColorAlphaString = self["startColorAlpha"] as? String,
           let endColorHex = self["endColor"] as? String,
           let endColorAlphaString = self["endColorAlpha"] as? String,
           let angle = Double(angleString),
           let startColorAlpha = Double(startColorAlphaString),
           let endColorAlpha = Double(endColorAlphaString) {
            return LinearGradient(startColor: Color(hex: startColorHex, alpha: startColorAlpha / 100),
                                  endColor: Color(hex: endColorHex, alpha: endColorAlpha / 100),
                                  angle: angle)
        } else {
            return LinearGradient(startColor: Color.clear,
                                  endColor: Color.clear,
                                  angle: 0)
        }
    }
}
