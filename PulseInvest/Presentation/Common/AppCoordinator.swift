import UIKit

@MainActor
final class AppCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    private var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showCoinList()
    }
    
    private func showCoinList() {
        let coordinator: CoinListCoordinator = CoinListCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
