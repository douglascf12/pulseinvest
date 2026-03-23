import Foundation

@MainActor
final class CoinsViewModel {
    
    private let repository: CoinRepositoryProtocol
    
    var onStateChange: ((CoinsViewState) -> Void)?
    
    init(repository: CoinRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchCoins() {
        onStateChange?(.loading)
        
        Task {
            do {
                
                let coins = try await repository.fetchCoins()
                
                if coins.isEmpty {
                    onStateChange?(.empty)
                } else {
                    onStateChange?(.success(coins))
                }
                
            } catch {
                let uiError = ErrorMapper.map(error)
                onStateChange?(.error(uiError))
            }
        }
    }
    
}
