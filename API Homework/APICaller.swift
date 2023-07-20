import Foundation

final class APICaller {
    
    static let shared = APICaller()
    private var session: URLSession
    
    private init(){
        self.session = URLSession.init(configuration: URLSessionConfiguration.default)
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else {
            return
        }
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        completion(request)
    }
    
    func getRequest<T: Codable, P:BaseRequestParams>(request params: P, baseURL: String, endpoint: String, completion: @escaping(T?, Error?) -> Void) {
        createRequest(with: URL(string: baseURL + endpoint + params.toString()), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                if let error = error {
                    completion(nil, error)
                }
               else if let data = data {
                   do {
                       let result = try JSONDecoder().decode(T.self, from: data)
                       completion(result, nil)
                   }
                   catch {
                       completion(nil, error)
                   }
                }
            }
            task.resume()
        }
    }
    
    func getImage(imageURL: String , completion: @escaping (Data?, Error?) -> (Void)) {
        guard let url = URL(string: imageURL) else {
            completion(nil, NetworkError.badData)
            return
        }
        let task = session.downloadTask(with: url) { (localUrl: URL?, response: URLResponse?, error: Error?) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, NetworkError.badResponse)
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkError.badStatusCode(httpResponse.statusCode))
                return
            }
            guard let localUrl = localUrl else {
                completion(nil, error)
                return
            }
            do {
                let data = try Data(contentsOf: localUrl)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}


