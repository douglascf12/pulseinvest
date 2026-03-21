import Foundation

final class CoinRepository: CoinRepositoryProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchCoins() async throws -> [Coin] {
        guard let url = Endpoints.coins() else {
            throw AppError.invalidURL
        }
        
        let data = try await apiClient.fetchData(from: url)
        
        print("Raw data:", data)
        
        return []
    }
}
