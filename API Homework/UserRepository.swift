import Foundation

protocol UserRepository {
    func getSearchUser(params: SearchUserRequestParams, completion: @escaping ([User]?, Error?) -> Void)
    
    func getProfileUser(params: ProfileUserRequestParams, completion: @escaping (UserProfile?, Error?) -> Void)

    func getFollowersUser(params: FollowersUserRequestParams, completion: @escaping ([User]?, Error?) -> Void)
    
    func getFollowingUser(params: FollowingUserRequestParams, completion: @escaping ([User]?, Error?) -> Void)
}
