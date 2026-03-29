import Foundation

@MainActor
final class CoinsViewModel {
    
    private let repository: CoinRepositoryProtocol
    
    // MARK: - Outputs
    
    var onLoading: (() -> Void)?
    var onCoinsLoaded: (([Coin]) -> Void)?
    var onError: ((UIError) -> Void)?
    var onEmpty: (() -> Void)?
        
    init(repository: CoinRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchCoins() {
        onLoading?()
        
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
            onEmpty?()
        } else {
            onCoinsLoaded?(coins)
        }
    }
    
    func handleError(_ error: Error) {
        let uiError: UIError = ErrorMapper.map(error)
        onError?(uiError)
    }
}
