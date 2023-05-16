import Foundation

// MARK: - Cache type

enum ImageCacheType {
    case tableSize
    case fullSized
}

// MARK: - Data cashing service protocol

protocol DataCashingServiceProtocol {
    func cacheImage(_ type: ImageCacheType, data: Data, with id: Int)
    func getCachedImageData(with id: Int, from type: ImageCacheType) -> Data?
    func removeObject(with id: Int, from type: ImageCacheType)
    func clearAllCache()
}

// MARK: - Data cashin service

final class DataCashingService: DataCashingServiceProtocol {
    
    private let tinyCache = NSCache<NSNumber, NSData>()
    private let heavyCache = NSCache<NSNumber, NSData>()
    
    init() {
        tinyCache.countLimit = 40
        heavyCache.countLimit = 10
    }
    
    func cacheImage(_ type: ImageCacheType, data: Data, with id: Int) {
        switch type {
            case .tableSize:
                tinyCache.setObject(NSData(data: data), forKey: NSNumber(value: id))
            case .fullSized:
                heavyCache.setObject(NSData(data: data), forKey: NSNumber(value: id))
        }
    }
    
    func getCachedImageData(with id: Int, from type: ImageCacheType) -> Data? {
        switch type {
            case .tableSize:
                return tinyCache.object(forKey: NSNumber(value: id)) as Data?
            case .fullSized:
                return heavyCache.object(forKey: NSNumber(value: id)) as Data?
        }
    }
    
    func removeObject(with id: Int, from type: ImageCacheType) {
        switch type {
            case .tableSize:
                tinyCache.removeObject(forKey: NSNumber(value: id))
            case .fullSized:
                heavyCache.removeObject(forKey: NSNumber(value: id))
        }
    }
    
    func clearAllCache() {
        tinyCache.removeAllObjects()
        heavyCache.removeAllObjects()
    }
}
