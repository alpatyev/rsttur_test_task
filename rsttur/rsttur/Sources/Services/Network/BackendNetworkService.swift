import Foundation

// MARK: - "Backend" protocol

protocol BackendNetworkServiceProtocol {
    func fetchRequest<ExpectedType: Decodable>(requestType: BackendRequestType, completion: @escaping (ExpectedType?, BackendNetworkError?) -> ())
}

// MARK: - "Backend" network service

final class BackendNetworkService: BackendNetworkServiceProtocol {
    
    private let session = URLSession.shared
    private let urlBuilder: BackendURLBuilderProtocol
    private let requestBuilder: BackendRequestBuilderProtocol
    
    init() {
        urlBuilder = BackendURLBuilder()
        requestBuilder = BackendRequestBuilder()
        
        self.fetchRequest(requestType: .objectsList) { (result: ResponseDataModel?, _) in
            print(result?.categories ?? "-")
        }
    }
    
    func fetchRequest<ExpectedType: Decodable>(requestType: BackendRequestType, completion: @escaping (ExpectedType?, BackendNetworkError?) -> ()) {
        guard let url = urlBuilder.createURL(using: requestType) else {
            completion(nil, .urlError("Invalid url for request: \(requestType.name)"))
            return
        }
        
        let request = requestBuilder.createRequest(using: requestType, url: url)
        
        let newTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, .serverError("Server error. Abort request with \(error?.localizedDescription ?? "")"))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                completion(nil, .serverError("Invalid response \(response.debugDescription)"))
                return
            }
            
            guard let responseData = data else {
                completion(nil, .serverError("No data for request: \(requestType.name)"))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(BackendResponseContainer<ExpectedType>.self, from: responseData)
                completion(result.data, nil)
            } catch let decodingError {
                completion(nil, .decodingError(decodingError.localizedDescription))
            }
        }
        
        newTask.resume()
    }
}
