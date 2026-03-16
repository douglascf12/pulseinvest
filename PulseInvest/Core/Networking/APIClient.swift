import Foundation

final class APIClient: APIClientProtocol {
    func fetchData(from url: URL) async throws -> Data {
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
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
