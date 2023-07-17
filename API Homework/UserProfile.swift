import Foundation

struct UserProfile: Codable{
    let bio : String?
    let avatarURL, follwersURL, followingURL, htmlURL: String?
    let public_repos: Int?
    let location: String?
    let company: String?
}
