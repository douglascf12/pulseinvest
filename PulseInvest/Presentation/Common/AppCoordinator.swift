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
                _ = try await repository.fetchCoins()
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
