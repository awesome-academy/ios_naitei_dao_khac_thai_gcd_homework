import Foundation
import CoreData

struct FollowerUser: Codable {
    private let htmlURL:String?
    private let avatarURL: String?
    private let login: String?
    
    init(item: NSManagedObject){
        self.login = item.value(forKey: "login") as? String
        self.avatarURL = item.value(forKey: "avatar_url") as? String
        self.htmlURL = item.value(forKey: "html_url") as? String
    }
}
