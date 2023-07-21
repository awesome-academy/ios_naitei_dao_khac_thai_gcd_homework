import UIKit

final class UserSearchViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var users: [User] = []
    private var serviceProvider: RepositoryImplementation = RepositoryImplementation()
    private var previousText: String = "abc"
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSearchUser(name: "abc")
    }
    
    private func getSearchUser(name: String) {
        serviceProvider.getSearchUser(params: SearchUserRequestParams(searchKey: name)) { [weak self] (data, error) in
            guard let self = self else { return }
            if let error = error { print("Error fetching search users: \(error.localizedDescription)") }
            if let data = data {
                self.users = data
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension UserSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let profileScreen = storyBoard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController
        profileScreen?.bindData(user: users[indexPath.row])
        self.navigationController?.pushViewController(profileScreen!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = LayoutSettings.cellHeight.rawValue
        return cellHeight
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var query = searchText
        query = query.replacingOccurrences(of: " ", with: "")
        if query.isEmpty {
            self.getSearchUser(name: self.previousText)
        } else {
            if query.trimmingCharacters(in: .whitespaces).count >= 3 {
                self.previousText = query
                timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { (timer) in
                    self.getSearchUser(name: query)
                })
            }
        }
    }
}
