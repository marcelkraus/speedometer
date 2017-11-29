import UIKit

struct ThemeLoader {

    func loadThemes() -> [Theme] {
        return [
            Theme(backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), speedLabelColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), unitLabelColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), statusBarAppearance: .default),
            Theme(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), speedLabelColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), unitLabelColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), statusBarAppearance: .default),
            Theme(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), speedLabelColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), unitLabelColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), statusBarAppearance: .lightContent),

        ]
    }

}
