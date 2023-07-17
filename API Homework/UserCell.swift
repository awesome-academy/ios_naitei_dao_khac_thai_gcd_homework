import UIKit

final class UserCell: UITableViewCell {
    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var name  : UILabel!
    @IBOutlet private weak var git   : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUserCell(name: String, git: String, image: UIImage) {
        self.name.text    = name
        self.git.text     = git
        self.avatar.image = image
    }
}
