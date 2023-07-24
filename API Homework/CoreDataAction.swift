import Foundation
import CoreData

enum CoreDataAction {
    case deleteUser(User?)
    case getUsers(completion: ([NSManagedObject], Error?) -> Void)
    case checkUserInCoreData(User?, (Bool) -> Void)
}
