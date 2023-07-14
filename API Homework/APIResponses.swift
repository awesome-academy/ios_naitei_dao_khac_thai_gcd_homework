import Foundation

struct APISearchResponse: Codable {
    private let responseUserData : [UserData]
}

struct APIProfileResponse: Codable {
   private  let responseProfileData : UserProfile
}

struct APIFollowerResponse: Codable {
    private let responseFollowerList : [FollowerUser]
}
