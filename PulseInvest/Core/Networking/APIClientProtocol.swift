import Foundation

protocol APIClientProtocol {
    func fetchData(from url: URL) async throws -> Data
}
