import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let sampleDTO = CoinDTO(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
            currentPrice: 65000
        )
        
        if let coin = CoinMapper.map(dto: sampleDTO) {
            print("Mapped coin:", coin)
        }
        
        let invalidDTO = CoinDTO(
            id: nil,
            symbol: "eth",
            name: "Ethereum",
            image: nil,
            currentPrice: nil
        )
        
        let invalidCoin = CoinMapper.map(dto: invalidDTO)
        print("Invalid mapped coin:", invalidCoin as Any)
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.title = "PulseInvest"
        
        ClosureExamples.simpleClosureExample()
        ClosureExamples.closureWithParameters()
        ClosureExamples.trailingClosureExample()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
