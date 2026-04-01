import UIKit

@MainActor
final class CoinListCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: AppContainer
    
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let viewModel: CoinsViewModel = container.makeCoinsViewModel()
        let viewController: CoinsViewController = CoinsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func makeRepository() -> CoinRepositoryProtocol {
        let apiClient: APIClientProtocol = APIClient()
        let repository: CoinRepositoryProtocol = CoinRepository(apiClient: apiClient)
        return repository
    }
}
