import Foundation

final class APIClient: APIClientProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(from url: URL) async throws -> Data {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AppError.invalidResponse
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw AppError.networkFailure
            }
            
            return data
            
        } catch {
            throw AppError.unknown(error)
        }
        
    }
    
}
