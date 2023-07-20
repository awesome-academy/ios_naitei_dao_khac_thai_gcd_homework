import Foundation

final class RepositoryImplementation: UserRepository {
    
    private let apiCaller = APICaller.shared
    
    func getSearchUser(params: SearchUserRequestParams, completion: @escaping ([User]?, Error?) -> Void) {
        apiCaller.getRequest(request: params, baseURL: Constants.baseURL, endpoint: EndPoints.searchEndPoint.rawValue) {
            (data: APISearchResponse?, error) in
            if let data = data {
                completion(data.items, nil)
            }
        }
    }
    
    func getProfileUser(params: ProfileUserRequestParams, completion: @escaping (UserProfile?, Error?) -> Void) {
        apiCaller.getRequest(request: params, baseURL: Constants.baseURL, endpoint: EndPoints.profileEndPoint.rawValue) {
            (data: UserProfile?, error) in
            if let data = data {
                completion(data, nil)
            }
        }
    }
    
    func getFollowersUser(params: FollowersUserRequestParams, completion: @escaping ([User]?, Error?) -> Void) {
        apiCaller.getRequest(request: params, baseURL: Constants.baseURL, endpoint: EndPoints.profileEndPoint.rawValue) {
            (data: [User]?, error) in
            if let data = data {
                completion(data, nil)
            }
        }
    }
    
    func getFollowingUser(params: FollowingUserRequestParams, completion: @escaping ([User]?, Error?) -> Void) {
        apiCaller.getRequest(request: params, baseURL: Constants.baseURL, endpoint: EndPoints.profileEndPoint.rawValue) {
            (data: [User]?, error) in
            if let data = data {
                completion(data, nil)
            }
        }
    }
}
