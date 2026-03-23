import Foundation

enum CoinsViewState {
    case loading
    case success([Coin])
    case error(UIError)
    case empty
}
