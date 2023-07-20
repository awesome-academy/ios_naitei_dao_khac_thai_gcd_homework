import Foundation

struct UserProfile: Codable {
    let name: String?
    let bio : String?
    let avatarURL, htmlURL: String?
    let public_repos: Int?
    let location: String?
    let company: String?
    let followers: Int?
    let following: Int?
    let reposURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case bio = "bio"
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case company = "company"
        case public_repos = "public_repos"
        case location = "location"
        case followers = "followers"
        case following = "following"
        case reposURL = "repos_url"
    }
}
