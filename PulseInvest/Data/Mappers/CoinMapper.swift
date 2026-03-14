import Foundation

struct CoinMapper {
    static func map(dto: CoinDTO) -> Coin? {
        guard
            let id = dto.id, !id.isEmpty,
            let symbol = dto.symbol, !symbol.isEmpty,
            let name = dto.name, !name.isEmpty
        else { return nil }
        
        let imageURL = dto.image.flatMap(URL.init(string:))
        let currentPrice = dto.currentPrice ?? 0
        
        return Coin(id: id, symbol: symbol, name: name, imageURL: imageURL, currentPrice: currentPrice)
    }
}
