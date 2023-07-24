import UIKit

final class UserProfileViewController: UIViewController {
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var bio: UILabel!
    @IBOutlet private weak var followerCount: UILabel!
    @IBOutlet private weak var followingCount: UILabel!
    @IBOutlet private weak var repoCount: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var followingButton: UIButton!
    @IBOutlet private weak var followersButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    private let apiCaller = APICaller.shared
    private let coreData = CoreData.shared
    private var serviceProvider: RepositoryImplementation = RepositoryImplementation()
    private var isFollowerButtonPressed: Bool = true
    private var isFavorited = false
    private var user: User?
    private var followingUsers: [User] = []
    private var followerUsers: [User] = []
    private var primaryColor: Colors = .primaryColor
    private var heartColor: Colors = .heartColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI(){
        avatarImageView.circleView()
        favoriteButton.circleView()
        configFollowerAndFollowingButton()
        infoView.layer.cornerRadius = 20
    }
    
     func bindData(user: User){
         apiCaller.getImage(imageURL: (user.avatarURL ?? "")) { [weak self] (data, error)  in
             guard let self = self else { return }
             if let error = error { print("Error fetching user's avatar: \(error.localizedDescription)") }
             if let data = data {
                 DispatchQueue.main.async { [weak self] in
                     guard let self = self else { return }
                     self.avatarImageView.image = UIImage(data: data)
                 }
             }
         }
         self.user = user
         self.updateUser(name: user.login ?? "")
         self.getFollowersAndFollowingUsers(name: user.login ?? "")
         DispatchQueue.main.async { [weak self] in
             guard let self = self else { return }
             self.checkUserIsFavorited(user: user)
         }
    }
    
    private func checkUserIsFavorited(user: User) {
        coreData.performCoreDataAction(.checkUserInCoreData(user) { [weak self] userExists in
            guard let self = self else { return }
            self.favoriteButton.backgroundColor = userExists ? .systemPink : self.heartColor.uiColor
            self.favoriteButton.setImage(UIImage(systemName: userExists ? "heart.fill" : "heart"), for: .normal)
            self.isFavorited = userExists
        })
    }
    
    private func updateUser(name: String){
        serviceProvider.getProfileUser(params: ProfileUserRequestParams(login: name)) {  [weak self] (data, error) in
        guard let self = self else { return }
        if let error = error { print("Error fetching user's profile: \(error.localizedDescription)") }
        if let data = data {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.upadateLabels(data: data)
            }
        }
    }
}
    
    private func upadateLabels(data: UserProfile) {
        self.name.text = "\(data.name ?? "no name")-\(data.location ?? "")"
        self.followerCount.text = "\(data.followers ?? 0)"
        self.followerCount.text = "\(data.following ?? 0)"
        self.repoCount.text = "\(data.public_repos ?? 0)"
        self.bio.text = "\(data.bio ?? "no bio")"
    }
    
    private func getFollowersAndFollowingUsers(name: String) {
        serviceProvider.getFollowersUser(params: FollowersUserRequestParams(login: name)) { [weak self] (data, error) in
            guard let self = self else { return }
            if let error = error { print("Error fetching follower users: \(error.localizedDescription)") }
            if let data = data {
                self.followerUsers = data
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
            }
        }
        
        serviceProvider.getFollowingUser(params: FollowingUserRequestParams(login: name)) { [weak self] (data, error) in
            guard let self = self else { return }
            if let error = error { print("Error fetching following users: \(error.localizedDescription)") }
            if let data = data {
                self.followingUsers = data
            }
        }
    }
    
    private func configFollowerAndFollowingButton() {
        followersButton.topCornerRadius(cornerRadius: 10)
        followingButton.topCornerRadius(cornerRadius: 10)
         _ = isFollowerButtonPressed ? (
            followersButton.backgroundColor = .white,
            followersButton.tintColor = primaryColor.uiColor,
            followingButton.backgroundColor = primaryColor.uiColor,
            followingButton.tintColor = .white
        ) : (
            followingButton.backgroundColor = .white,
            followingButton.tintColor = primaryColor.uiColor,
            followersButton.backgroundColor = primaryColor.uiColor,
            followersButton.tintColor = .white
        )
    }
    
    @IBAction private func followerButtonTapped(_ sender: Any) {
        if !isFollowerButtonPressed {
            isFollowerButtonPressed = true
            configFollowerAndFollowingButton()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction private func followingButtonTapped(_ sender: Any) {
        if isFollowerButtonPressed {
            isFollowerButtonPressed = false
            configFollowerAndFollowingButton()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        configFavoriteButton()
    }
    
    private func configFavoriteButton() {
        if isFavorited {
            coreData.performCoreDataAction(.deleteUser(user))
            favoriteButton.backgroundColor = heartColor.uiColor
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isFavorited = false
        } else {
            coreData.addUser(user: user)
            favoriteButton.backgroundColor = .systemPink
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isFavorited = true
        }
    }
}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFollowerButtonPressed ? followerUsers.count : followingUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomUserCell", for: indexPath) as? UserCell
        else { return UITableViewCell() }
        isFollowerButtonPressed ? cell.setUserCell(user: followerUsers[indexPath.row]) : cell.setUserCell(user: followingUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let profileScreen = storyBoard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController else { return }
        isFollowerButtonPressed ? profileScreen.bindData(user: followerUsers[indexPath.row]) :             profileScreen.bindData(user: followingUsers[indexPath.row])
        self.navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = LayoutSettings.cellHeight.rawValue
        return cellHeight
    }
}
