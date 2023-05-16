
// MARK: - All possible network errors

enum BackendNetworkError: Error {
    case urlError(String)
    case serverError(String)
    case decodingError(String)
}
