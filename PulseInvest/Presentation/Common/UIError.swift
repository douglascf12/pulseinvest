import Foundation

enum UIError {
    
    case generic
    case network
    case decoding
    
    var message: String {
        switch self {
        case .generic:
            return "Algo deu errado. Tente novamente."
        case .network:
            return "Sem conexão com a internet"
        case .decoding:
            return "Erro ao processar dados"
        }
    }
    
}
