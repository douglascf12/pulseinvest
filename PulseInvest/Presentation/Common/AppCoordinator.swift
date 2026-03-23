import UIKit

@MainActor
final class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let repository: CoinRepositoryProtocol = makeRepository()
        let viewModel: CoinsViewModel = CoinsViewModel(repository: repository)
        let viewController: CoinsViewController = CoinsViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func makeRepository() -> CoinRepositoryProtocol {
        let apiClient = APIClient()
        return CoinRepository(apiClient: apiClient)
    }
    
}
