import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        Task {
            let repository = CoinRepository(apiClient: APIClient())
            
            do {
                let coins = try await repository.fetchCoins()
                
                print("Coins count:", coins.count)
                
                coins.prefix(5).forEach {
                    print($0.name, $0.currentPrice)
                }
                
            } catch {
                print("Error", error)
            }
        }
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.title = "PulseInvest"
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
