import Foundation

enum NetworkError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}
