import Foundation

protocol CoinRepositoryProtocol {
    func fetchCoins() async throws -> [Coin]
}
