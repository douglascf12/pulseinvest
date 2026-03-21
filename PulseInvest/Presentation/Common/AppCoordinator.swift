import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        loadCoins()
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.title = "PulseInvest"
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func loadCoins() {
        
        Task {
            do {
                
                let repository = makeRepository()
                let coins = try await repository.fetchCoins()
                
                print("Coins:", coins.prefix(3))
                
            } catch {
                print("Error", error)
            }
        }
    }
    
    private func makeRepository() -> CoinRepositoryProtocol {
        let apiClient = APIClient()
        return CoinRepository(apiClient: apiClient)
    }
    
}
