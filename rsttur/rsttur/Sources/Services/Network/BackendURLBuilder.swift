import Foundation

// MARK: - "Backend" url builder protocol

protocol BackendURLBuilderProtocol {
    func createURL(using requestType: BackendRequestType) -> URL?
}

// MARK: - "Backend" url builder

final class BackendURLBuilder: BackendURLBuilderProtocol {
    
    private lazy var components = URLComponents()
    
    func createURL(using requestType: BackendRequestType) -> URL? {
        components = URLComponents()
        
        switch requestType {
            case .objectsList:
                setObjectsListURL()
        }
        
        return components.url
    }
    
    private func setObjectsListURL() {
        components.scheme = "https"
        components.host = "rsttur.ru"
        components.path = "/api/base-app/map"
    }
}

