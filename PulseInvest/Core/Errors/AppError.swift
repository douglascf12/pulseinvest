import Foundation

enum AppError: Error {
    case invalidURL
    case networkFailure
    case invalidResponse
    case decodingFailure
    case unknown(Error)
}
