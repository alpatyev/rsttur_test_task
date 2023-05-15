
// MARK: - Request type

enum BackendRequestType {
    case objectsList
    
    var name: String {
        return String(describing: self)
    }
    
    var expectedResponseType: Decodable.Type {
        switch self {
            case .objectsList:
                return String.self
        }
    }
}
