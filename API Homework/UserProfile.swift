import Foundation

struct UserProfile: Codable{
    private let bio : String
    private let follwersURL: String
    private let followingURL:String
    private let avatarURL: String
    private let public_repos: Int
    private let location: String
    private let company: String
    private let htmlURL: String
}
