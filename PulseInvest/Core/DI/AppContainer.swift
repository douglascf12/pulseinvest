import Foundation

final class AppContainer {
    
    // MARK: - Core
    
    lazy var apiClient: APIClientProtocol = APIClient()
    
    // MARK: - Repositories
    
    lazy var coinRepository: CoinRepositoryProtocol = CoinRepository(apiClient: apiClient)
    
    // MARK: - ViewModels
    
    @MainActor
    func makeCoinsViewModel() -> CoinsViewModel {
        CoinsViewModel(repository: coinRepository)
    }
}
