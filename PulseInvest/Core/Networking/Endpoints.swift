import Foundation

enum Endpoints {
    
    static func coins() -> URL? {
        
        var components = URLComponents(string: "https://api.coingecko.com/api/v3/coins/markets")
        
        components?.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc")
        ]
        
        return components?.url
    }
}
