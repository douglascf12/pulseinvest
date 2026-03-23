import Foundation

struct ErrorMapper {
    
    static func map(_ error: Error) -> UIError {
        
        guard let appError = error as? AppError else {
            return .generic
        }
        
        switch appError {
        case .networkFailure:
            return .network
        case .decodingFailure:
            return .decoding
        default:
            return .generic
        }
        
    }
    
}
