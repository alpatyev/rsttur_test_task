import UIKit

// MARK: - Compress size to small image (~20%)

extension Data {
    func compressedAsImage(_ power: Double) -> Data? {
        if let image = UIImage(data: self) {
            return image.jpegData(compressionQuality: power)
        } else {
            return nil
        }
    }
}
