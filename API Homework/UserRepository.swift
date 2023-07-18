import Foundation

protocol UserRepository {
    func getSearchUser(params: SearchUserRequestParams, completion: @escaping (APISearchResponse?, Error?) -> Void)
    
    func getProfileUser(params: ProfileUserRequestParams, completion: @escaping (APIProfileResponse?, Error?) -> Void)

    func getFollowersUser(params: FollowersUserRequestParams, completion: @escaping (APIFollowerResponse?, Error?) -> Void)
    
    func getFollowingUser(params: FollowingUserRequestParams, completion: @escaping (APIFollowerResponse?, Error?) -> Void)
    
}
