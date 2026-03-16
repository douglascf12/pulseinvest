import Foundation

final class CoinRepository: CoinRepositoryProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchCoins() async throws -> [Coin] {
        return []
    }
}
