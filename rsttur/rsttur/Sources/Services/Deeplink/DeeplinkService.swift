import UIKit
import SwiftUI

// MARK: - Deeplink protocol

protocol DeeplinkServiceProtocol {
    func twoGisDeeplink(to endPoint: NavigationPointModel)
    func setupNewCoordinate(from userPoint: NavigationPointModel)
}

// MARK: - Deeplink service

final class DeeplinkService: DeeplinkServiceProtocol {
  
    func setupNewCoordinate(from userPoint: NavigationPointModel) {
        self.userPoint = userPoint
    }
    
    
    private var userPoint: NavigationPointModel?
    
    func twoGisDeeplink(to endPoint: NavigationPointModel) {
        guard let userPointExists = userPoint,
              let navigationURL = createURL(from: userPointExists, to: endPoint) else { return }

        if UIApplication.shared.canOpenURL(navigationURL) {
            UIApplication.shared.open(navigationURL, options: [:], completionHandler: nil)
        } else {
            if let appStoreURl = URL(string: "https://apps.apple.com/ru/app/2гис-навигатор-карты-справочник/id481627348") {
                UIApplication.shared.open(appStoreURl, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func createURL(from startPoint: NavigationPointModel, to endPoint: NavigationPointModel) -> URL? {
        let startLat = startPoint.latitude
        let startLong = startPoint.longitude
        
        let endLat = endPoint.latitude
        let endLong = endPoint.longitude

        return URL(string: "dgis://2gis.ru/routeSearch/rsType/car/from/\(startLong),\(startLat)/to/\(endLong),\(endLat)")
    }
}
