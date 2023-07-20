import UIKit

final class UserSearchViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var users: [User] = []
    private var serviceProvider: RepositoryImplementation = RepositoryImplementation()
    
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
        performSegue(withIdentifier: Constants.toUserProfileSegue, sender: users[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = LayoutSettings.cellHeight.rawValue
        return cellHeight
    }
}
