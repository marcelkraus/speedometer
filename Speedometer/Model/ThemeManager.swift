import UIKit

class ThemeManager {

    struct Theme: Equatable {
        let color: (background: UIColor, speedLabel: UIColor, unitLabel: UIColor)
        let statusBarStyle: UIStatusBarStyle

        static func ==(lhs: Theme, rhs: Theme) -> Bool {
            return lhs.color.background == rhs.color.background && lhs.color.speedLabel == rhs.color.speedLabel && lhs.color.unitLabel == rhs.color.unitLabel && lhs.statusBarStyle == rhs.statusBarStyle
        }
    }

    var current = ThemeManager.themes.first!

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
        Theme(color: (background: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), speedLabel: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), unitLabel: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), statusBarStyle: .default),
        Theme(color: (background: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), speedLabel: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), unitLabel: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), statusBarStyle: .default),
        Theme(color: (background: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), speedLabel: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), unitLabel: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), statusBarStyle: .lightContent),
    ]

}
