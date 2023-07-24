import UIKit
import CoreData

final class FavoriteUserViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var users: [User] = []
    private let coreData = CoreData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreData.performCoreDataAction(.getUsers() { [weak self] items, error in
            guard let self = self else { return }
            guard error == nil else {
                print("Could not fetch. \(String(describing: error))")
                return
            }
            self.users = items.map { [unowned self] item in
                return self.changeNSManagedObjectToUserModel(nsManagedObject: item)
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        })
    }
    
    private func changeNSManagedObjectToUserModel (nsManagedObject: NSManagedObject) -> User {
        let user = User (
            avatarURL: nsManagedObject.value(forKey: "avatarURL") as? String ?? "",
            htmlURL: nsManagedObject.value(forKey: "htmlURL") as? String ?? "",
            login: nsManagedObject.value(forKey: "login") as? String ?? "",
            id: nsManagedObject.value(forKey: "id") as? Int ?? 0,
            url: nsManagedObject.value(forKey: "url") as? String ?? "",
            followersURL: nsManagedObject.value(forKey: "followersURL") as? String ?? "",
            followingURL: nsManagedObject.value(forKey: "followingURL") as? String ?? "",
            reposURL: nsManagedObject.value(forKey: "reposURL") as? String ?? ""
        )
        return user
    }
}

extension FavoriteUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomUserCell", for: indexPath) as? UserCell
        else { return UITableViewCell() }
        cell.setUserCell(user: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let profileScreen = storyBoard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController else { return }
        profileScreen.bindData(user: users[indexPath.row])
        self.navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = LayoutSettings.cellHeight.rawValue
        return cellHeight
    }
}
