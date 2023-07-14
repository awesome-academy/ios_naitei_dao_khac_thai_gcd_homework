import Foundation

final class APICaller{
    
    static let shared = APICaller()
    
    private init(){}
    
    public func getUserData(searchKey: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: Constants.searchURL + searchKey) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APISearchResponse.self, from: data)
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getUserProfile(searchKey: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: Constants.profileURL + searchKey) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIProfileResponse.self, from: data)
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getFollowers(searchKey: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: Constants.profileURL + searchKey + Constants.followersURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIFollowerResponse.self, from: data)
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getFollowingUsers(searchKey: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: Constants.profileURL + searchKey + Constants.followingURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIFollowerResponse.self, from: data)
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}



