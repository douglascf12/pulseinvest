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
        
        do {
            
            let decoder = JSONDecoder()
            let dtoList = try decoder.decode([CoinDTO].self, from: data)
            
            let coins = dtoList.compactMap { CoinMapper.map(dto: $0) }
            
            return coins
            
        } catch {
            throw AppError.decodingFailure
        }
    }
    
}
