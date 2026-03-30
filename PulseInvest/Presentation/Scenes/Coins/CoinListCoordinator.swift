import UIKit

@MainActor
final class CoinListCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let repository: CoinRepositoryProtocol = makeRepository()
        let viewModel: CoinsViewModel = CoinsViewModel(repository: repository)
        let viewController: CoinsViewController = CoinsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func makeRepository() -> CoinRepositoryProtocol {
        let apiClient: APIClientProtocol = APIClient()
        let repository: CoinRepositoryProtocol = CoinRepository(apiClient: apiClient)
        return repository
    }
}
