import SwiftUI

// MARK: - Creates LinearGradientModel from dictionary, also creates gradient view

extension Dictionary where Key == String, Value == Any {
    func linearGradientModel() -> LinearGradientModel? {
        LinearGradientModel(dict: self)
    }
    
    func linearGradient() -> LinearGradient {
        if let gradientModel = self.linearGradientModel() {
            return LinearGradient(model: gradientModel)
        } else {
            return LinearGradient(startColor: Color.clear,
                                  endColor: Color.clear,
                                  angle: 0)
        }
    }
}
