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
                
                handleSuccess(coins)
            } catch {
                handleError(error)
            }
        }
    }
}

// MARK: - Handlers
private extension CoinsViewModel {
    
    func handleSuccess(_ coins: [Coin]) {
        if coins.isEmpty {
            onStateChange?(.empty)
        } else {
            onStateChange?(.success(coins))
        }
    }
    
    func handleError(_ error: Error) {
        let uiError: UIError = ErrorMapper.map(error)
        onStateChange?(.error(uiError))
    }
}
