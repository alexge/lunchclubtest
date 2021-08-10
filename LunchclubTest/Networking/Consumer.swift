import Foundation

class Consumer: HTTPConsumer {
    private let session: URLSession
    
    private struct RawResponse: HTTPResponse {
        let data: Data?
        let error: Error?
    }
    
    init(_ session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func response(of request: URLRequest, completionHandler: @escaping ResponseCompletion) {
        session.dataTask(with: request) { [weak self] (data, _, error) in
            guard let _ = self else { return }
            
            completionHandler(RawResponse(data: data, error: error))
        }.resume()
    }
    
    func response<T: Decodable>(of request: URLRequest, completionHandler: @escaping ResponseTypedCompletion<T>) {
        response(of: request) { [weak self] response in
            guard let _ = self else { return }
            
            guard let data = response.data else {
                completionHandler(nil, response.error)
                return
            }
            
            do {
                let parser = JSONParser()
                let result = try parser.parse(data) as T
                
                completionHandler(result, nil)
            } catch let error as JSONParser.ParseError {
                completionHandler(nil, error.errorDetails)
            } catch let error {
                completionHandler(nil, error)
            }
        }
    }
}
