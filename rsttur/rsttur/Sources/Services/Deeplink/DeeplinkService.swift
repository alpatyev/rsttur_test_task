import UIKit
import SwiftUI

// MARK: - Deeplink protocol

protocol DeeplinkServiceProtocol {
    func twoGisDeeplink(from startPoint: NavigationPointModel, to endPoint: NavigationPointModel)
}

// MARK: - Deeplink service

final class DeeplinkService: DeeplinkServiceProtocol {
    func twoGisDeeplink(from startPoint: NavigationPointModel, to endPoint: NavigationPointModel) {
        guard let navigatorURL = createURL(from: startPoint, to: endPoint) else { return }
        
        if UIApplication.shared.canOpenURL(navigatorURL) {
            UIApplication.shared.open(navigatorURL, options: [:], completionHandler: nil)
        } else {
            if let appStoreURl = URL(string: "https://itunes.apple.com/ru/app/id481627348?mt=8") {
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
