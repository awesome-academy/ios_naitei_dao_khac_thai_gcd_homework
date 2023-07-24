import Foundation
import UIKit
import CoreData

final class CoreData {
    static let shared = CoreData()
    private var appDelegate: AppDelegate?
    
    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    func performCoreDataAction(_ action: CoreDataAction) {
        guard let appDelegate = appDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteUser")
        fetchRequest.includesPropertyValues = false

        switch action {
        case .deleteUser(let user):
            do {
                let items = try managedContext.fetch(fetchRequest)
                for item in items {
                    if (item.value(forKey: "id") as? Int == (user?.id ?? 0)) {
                        managedContext.delete(item)
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }

        case .getUsers(let completion):
            do {
                let items = try managedContext.fetch(fetchRequest)
                completion(items, nil)
            } catch let error as NSError {
                completion([], error)
                return
            }

        case .checkUserInCoreData(let user, let completion):
            do {
                let items = try managedContext.fetch(fetchRequest)
                for item in items {
                    if (item.value(forKey: "id") as? Int == (user?.id)) {
                        completion(true)
                        return
                    }
                }
            } catch {
                print("Could not fetch. \(error)")
            }
            completion(false)
        }
    }


    func addUser(user: User?) {
        guard let appDelegate = appDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteUser", in: managedContext)
        else { return }
        let managedObjectUser = NSManagedObject(entity: entity, insertInto: managedContext)
        managedObjectUser.setValue(user?.login, forKey: "login")
        managedObjectUser.setValue(user?.avatarURL, forKey: "avatarURL")
        managedObjectUser.setValue(user?.htmlURL, forKey: "htmlURL")
        managedObjectUser.setValue(user?.followersURL, forKey: "followersURL")
        managedObjectUser.setValue(user?.followingURL, forKey: "followingURL")
        managedObjectUser.setValue(user?.id, forKey: "id")
        managedObjectUser.setValue(user?.reposURL, forKey: "reposURL")
        managedObjectUser.setValue(user?.isFavorited, forKey: "isFavorited")
        managedObjectUser.setValue(user?.url, forKey: "url")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Can not save, err: \(error)")
        }
    }
}



