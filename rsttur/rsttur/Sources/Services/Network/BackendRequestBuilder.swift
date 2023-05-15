import Foundation

// MARK: - "Backend" request builder protocol

protocol BackendRequestBuilderProtocol {
    func createRequest(using requestType: BackendRequestType, url: URL) -> URLRequest
}

// MARK: - "Backend" request builder

final class BackendRequestBuilder: BackendRequestBuilderProtocol {
    
    func createRequest(using requestType: BackendRequestType, url: URL) -> URLRequest {
        switch requestType {
            case .objectsList:
                return createObjectsListRequest(url)
        }
    }
    
    private func createObjectsListRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

