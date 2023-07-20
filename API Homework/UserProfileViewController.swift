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
    
    private var followingButtonPressed: Bool = false
    private var user: User?
    private var followingUsers: [User] = []
    private var followerUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingButtonPressed ? followingUsers.count : followerUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomUserCell", for: indexPath) as? UserCell
        else { return UITableViewCell() }
        followingButtonPressed ? cell.setUserCell(user: followingUsers[indexPath.row]) : cell.setUserCell(user: followerUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        followingButtonPressed
        ? performSegue(withIdentifier: Constants.toUserProfileSegue, sender: followingUsers[indexPath.row])
        : performSegue(withIdentifier: Constants.toUserProfileSegue, sender: followerUsers[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = LayoutSettings.cellHeight.rawValue
        return cellHeight
    }
}
