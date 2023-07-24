import Foundation

struct User: Codable {
    let avatarURL: String?
    let htmlURL: String?
    let login: String?
    let id: Int?
    let url: String?
    let followersURL: String?
    let followingURL: String?
    let reposURL: String?
    let isFavorited = false
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case id = "id"
        case url = "url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case reposURL = "repos_url"
    }
}
