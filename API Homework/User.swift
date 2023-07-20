import Foundation

struct User: Codable {
    let avatarURL: String?
    let htmlURL: String?
    let login: String?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}
