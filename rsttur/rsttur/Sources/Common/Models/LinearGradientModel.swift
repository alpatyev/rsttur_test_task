import SwiftUI

// MARK: - Linear gradient model

struct LinearGradientModel {
    let angle: Double
    let startColorHex: String
    let startColorAlpha: Double
    let endColorHex: String
    let endColorAlpha: Double
}

// MARK: - Init from key - value pairs

extension LinearGradientModel {
    init?(dict: [String: Any]) {
        guard let angleString = dict["angle"] as? String,
              let startColorHex = dict["startColor"] as? String,
              let startColorAlphaString = dict["startColorAlpha"] as? String,
              let endColorHex = dict["endColor"] as? String,
              let endColorAlphaString = dict["endColorAlpha"] as? String,
              let angle = Double(angleString),
              let startColorAlpha = Double(startColorAlphaString),
              let endColorAlpha = Double(endColorAlphaString) else { return nil }
        
        self.angle = angle
        self.startColorHex = startColorHex
        self.startColorAlpha = startColorAlpha / 100
        self.endColorHex = endColorHex
        self.endColorAlpha = endColorAlpha / 100
    }
}
