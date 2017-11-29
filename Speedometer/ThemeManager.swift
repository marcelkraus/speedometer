import UIKit

class ThemeManager {

    struct Theme: Equatable {
        let backgroundColor: UIColor
        let speedLabelColor: UIColor
        let unitLabelColor: UIColor
        let statusBarAppearance: UIStatusBarStyle

        static func ==(lhs: Theme, rhs: Theme) -> Bool {
            return lhs.backgroundColor == rhs.backgroundColor && lhs.speedLabelColor == rhs.speedLabelColor && lhs.unitLabelColor == rhs.unitLabelColor && lhs.statusBarAppearance == rhs.statusBarAppearance
        }
    }

    var current: Theme

    init() {
        current = ThemeManager.themes.first!
    }

    func next() {
        guard let index = ThemeManager.themes.index(of: current)?.advanced(by: +1), ThemeManager.themes.indices.contains(index) else {
            return
        }

        current = ThemeManager.themes[index]
    }

    func previous() {
        guard let index = ThemeManager.themes.index(of: current)?.advanced(by: -1), ThemeManager.themes.indices.contains(index) else {
            return
        }

        current = ThemeManager.themes[index]
    }

}

private extension ThemeManager {

    static let themes = [
        Theme(backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), speedLabelColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), unitLabelColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), statusBarAppearance: .default),
        Theme(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), speedLabelColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), unitLabelColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), statusBarAppearance: .default),
        Theme(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), speedLabelColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), unitLabelColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), statusBarAppearance: .lightContent),
    ]

}
