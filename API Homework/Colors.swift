import Foundation
import UIKit

enum Colors {
    case primaryColor
    case heartColor
    
    var uiColor: UIColor {
            switch self {
            case .primaryColor:
                return #colorLiteral(red: 0.2822310925, green: 0.3429890871, blue: 0.3248010278, alpha: 1)
            case .heartColor:
                return #colorLiteral(red: 0.9670718312, green: 0.5393305421, blue: 0.03985216469, alpha: 1)
            }
        }
}
