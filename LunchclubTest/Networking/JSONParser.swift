import Foundation

final class JSONParser {
    private let decoder: JSONDecoder
    
    enum ParseError: Error {
        case decodeFailure(_ error: Error?)
        
        var errorDetails: Error? {
            switch self {
            case .decodeFailure(let error): return error
            }
        }
    }
    
    init(_ decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    // MARK: JSONParser Services
    
    func parse<T: Decodable>(_ data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error {
            throw ParseError.decodeFailure(error)
        }
    }
}
