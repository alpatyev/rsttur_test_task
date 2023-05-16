import Foundation

// MARK: - Deeplink protocol

protocol DeeplinkServiceProtocol {
    func twoGisDeeplink(from startPoint: NavigationPointModel, to endPoint: NavigationPointModel)
}

// MARK: - Deeplink service

final class DeeplinkService: DeeplinkServiceProtocol {
    func twoGisDeeplink(from startPoint: NavigationPointModel, to endPoint: NavigationPointModel) {
        print(startPoint, endPoint)
    }
}
