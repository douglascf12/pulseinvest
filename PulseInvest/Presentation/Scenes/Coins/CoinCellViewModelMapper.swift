import UIKit

struct CoinCellViewModelMapper {
    
    static func map(_ coin: Coin) -> CoinCellViewModel {
        
        let changeValue: Double = coin.priceChangePercentage24h ?? 0
        let changeText: String = String(format: "%.2f%%", changeValue)
        let color: UIColor = changeValue >= 0 ? .systemGreen : .systemRed
        let priceText: String = String(format: "$%.2f", coin.currentPrice)
        
        return CoinCellViewModel(
            name: coin.name,
            symbol: coin.symbol.uppercased(),
            price: priceText,
            change: changeText,
            changeColor: color,
            imageURL: coin.imageURL
        )
    }
}
