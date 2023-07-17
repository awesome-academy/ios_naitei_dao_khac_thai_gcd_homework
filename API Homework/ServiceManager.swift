import Foundation

final class ServiceManager {
    static let shared = ServiceManager()
    
    private init() {}
    
    private let API = APICaller.shared
    
    func getSearchUser(request params: SearchUserRequestParams, completion: @escaping(Result<APISearchResponse, Error>) -> Void) {
        return API.getRequest(request: params, baseURL: Constants.baseURL, endpoint: Endpoints.searchEndPoint.rawValue, completion: completion)
    }
    
    func getProfileUser(request params: ProfileUserRequestParams, completion: @escaping(Result<APIProfileResponse, Error>) -> Void) {
        return API.getRequest(request: params, baseURL: Constants.baseURL, endpoint: Endpoints.profileEndPoint.rawValue, completion: completion)
    }
    
    func getFollowersUser(request params: FollowersUserRequestParams, completion: @escaping(Result<APIFollowerResponse, Error>) -> Void) {
        return API.getRequest(request: params, baseURL: Constants.baseURL, endpoint: Endpoints.profileEndPoint.rawValue, completion: completion)
    }
    
    func getFollowingsUser(request params: FollowingUserRequestParams, completion: @escaping(Result<APIFollowerResponse, Error>) -> Void) {
        return API.getRequest(request: params, baseURL: Constants.baseURL, endpoint: Endpoints.profileEndPoint.rawValue, completion: completion)
    }
}
