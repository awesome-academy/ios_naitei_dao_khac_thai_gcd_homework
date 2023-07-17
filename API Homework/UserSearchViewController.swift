import UIKit

final class UserSearchViewController: UIViewController {
    @IBOutlet private weak var searchInput: UITextField!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    private var userList: [UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension UserSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        guard let imageURL = URL(string: userList[indexPath.row].avatarURL!) else { return cell }
        if let data = try? Data(contentsOf: imageURL) {
            if let image = UIImage(data: data) {
                cell.setUserCell(name: userList[indexPath.row].login! , git:userList[indexPath.row].htmlURL! ,
                                 image: image)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.toUserProfileSegue, sender: userList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}