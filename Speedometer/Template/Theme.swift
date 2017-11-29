import UIKit

struct Theme: Equatable {

    let backgroundColor: UIColor
    let speedLabelColor: UIColor
    let unitLabelColor: UIColor
    let statusBarAppearance: UIStatusBarStyle

    static func ==(lhs: Theme, rhs: Theme) -> Bool {
        return lhs.backgroundColor == rhs.backgroundColor && lhs.speedLabelColor == rhs.speedLabelColor && lhs.unitLabelColor == rhs.unitLabelColor && lhs.statusBarAppearance == rhs.statusBarAppearance
    }

}
