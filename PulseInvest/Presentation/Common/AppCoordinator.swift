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
                
                let repository = CoinRepository(apiClient: APIClient())
                let coins = try await repository.fetchCoins()
                
                print("Coins:", coins.prefix(3))
                
            } catch {
                print("Error", error)
            }
        }
    }
}
