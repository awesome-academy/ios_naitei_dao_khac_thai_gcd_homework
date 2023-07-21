import Foundation
import UIKit

enum Colors {
    case primaryColor
    
    var uiColor: UIColor {
            switch self {
            case .primaryColor:
                return #colorLiteral(red: 0.2822310925, green: 0.3429890871, blue: 0.3248010278, alpha: 1)
            }
        }
}
