import UIKit

final class UserCell: UITableViewCell {
    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var name  : UILabel!
    @IBOutlet private weak var git   : UILabel!
    private let apiCaller = APICaller.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.circleView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUserCell(user: User) {
        self.apiCaller.getImage(imageURL: (user.avatarURL ?? "")) { [weak self] (data, error)  in
            guard let self = self else { return }
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.avatar.image = UIImage(data: data)
                }
            }
        }
        name.text = user.login
        git.text  = user.htmlURL
    }
}
