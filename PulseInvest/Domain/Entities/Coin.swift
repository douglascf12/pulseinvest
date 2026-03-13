import Foundation

struct Coin: Decodable {
    let id: String
    let symbol: String
    let name: String
    let imageURL: URL?
    let currentPrice: Double
}
