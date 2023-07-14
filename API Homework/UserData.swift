import Foundation

struct UserData: Codable {
    private let avatarURL: String
    private let login    : String
    private let htmlURL  : String
    
    public func getAvatarURL() -> String { return avatarURL }
    
    public func getLogin() -> String { return login }
    
    public func getHtmlURL() -> String { return htmlURL }
    
    
}
