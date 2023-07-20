import Foundation

struct APISearchResponse: Codable {
    let totalCount: Int
    let items : [User]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items = "items"
    }
}

struct APIProfileResponse: Codable {
    let profileResponse : UserProfile
}

struct APIFollowerResponse: Codable {
    let followerResponses : [User]
}
