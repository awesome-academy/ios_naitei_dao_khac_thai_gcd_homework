import Foundation

protocol BaseRequestParams: Codable {
    func toString() -> String
}

struct FollowersUserRequestParams: BaseRequestParams {
    let login: String
    
    public func toString() -> String {
        return "/\(login)/followers"
    }
}

struct FollowingUserRequestParams: BaseRequestParams {
    let login: String
    
    public func toString() -> String {
        return "/\(login)/following"
    }
}

struct ProfileUserRequestParams: BaseRequestParams {
    let login: String
    
    public func toString() -> String {
        return "/\(login)"
    }
}

struct SearchUserRequestParams: BaseRequestParams {
    let searchKey: String
    
    public func toString() -> String {
        return "?q=\(searchKey)"
    }
}
