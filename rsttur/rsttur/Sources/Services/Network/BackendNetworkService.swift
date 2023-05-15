import Foundation

// MARK: - "Backend" protocol

protocol BackendNetworkServiceProtocol {
    func fetchRequest<ExpectedType: Decodable>(requestType: BackendRequestType, completion: @escaping(ExpectedType?) -> ())
}

// MARK: - "Backend" network service

final class BackendNetworkService: BackendNetworkServiceProtocol {
    
    private let session = URLSession.shared
    private let urlBuilder: BackendURLBuilderProtocol
    private let requestBuilder: BackendRequestBuilderProtocol
    
    init() {
        urlBuilder = BackendURLBuilder()
        requestBuilder = BackendRequestBuilder()
        
        self.fetchRequest(requestType: .objectsList) { (result: ResponseDataModel?) in
            print(result?.categories)
        }
    }
    
    func fetchRequest<ExpectedType: Decodable>(requestType: BackendRequestType, completion: @escaping(ExpectedType?) -> ()) {
        guard let url = urlBuilder.createURL(using: requestType) else {
            completion(nil)
            return
        }
        
        let request = requestBuilder.createRequest(using: requestType, url: url)
        
        let newTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil)
                print("error response")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                completion(nil)
                print("invalid response")
                return
            }
            
            guard let responseData = data else {
                completion(nil)
                print("no data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(BackendResponseContainer<ExpectedType>.self, from: responseData)
                completion(result.data)
            } catch let decodingError {
                print(decodingError)
            }
          
        }
        
        newTask.resume()
    }
}
