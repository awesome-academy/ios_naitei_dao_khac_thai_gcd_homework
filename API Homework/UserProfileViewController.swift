import UIKit

final class UserProfileViewController: UIViewController {
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var bio: UILabel!
    @IBOutlet private weak var followerCount: UILabel!
    @IBOutlet private weak var followingCount: UILabel!
    @IBOutlet private weak var repoCount: UILabel!
    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var followingButton: UIButton!
    @IBOutlet private weak var followersButton: UIButton!
    private var users: [UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        guard let imageURL = URL(string: users[indexPath.row].avatarURL ?? "") else { return cell }
        if let data = try? Data(contentsOf: imageURL) {
            if let image = UIImage(data: data) {
                cell.setUserCell(name: users[indexPath.row].login ?? "" , git:users[indexPath.row].htmlURL ?? "" ,
                                 image: image)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.toUserProfileSegue, sender: users[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = LayoutSettings.cellHeight.rawValue
        return cellHeight
    }
}
