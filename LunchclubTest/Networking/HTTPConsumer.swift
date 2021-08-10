import Foundation

typealias ResponseCompletion = ((HTTPResponse) -> Void)
typealias ResponseTypedCompletion<T: Decodable> = ((T?, _ error: Error?) -> Void)

protocol HTTPResponse {
    var data: Data? { get }
    var error: Error? { get }
}

protocol HTTPConsumer: class {    
    func response(of request: URLRequest, completionHandler: @escaping ResponseCompletion)
    func response<T: Decodable>(of request: URLRequest, completionHandler: @escaping ResponseTypedCompletion<T>)
}
