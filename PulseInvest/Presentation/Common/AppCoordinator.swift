import UIKit

@MainActor
final class AppCoordinator {
    
    private let window: UIWindow
    private let container: AppContainer
    private let navigationController: UINavigationController
    
    private var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow, container: AppContainer) {
        self.window = window
        self.container = container
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showCoinList()
    }
    
    private func showCoinList() {
        let coordinator: CoinListCoordinator = CoinListCoordinator(navigationController: navigationController, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
