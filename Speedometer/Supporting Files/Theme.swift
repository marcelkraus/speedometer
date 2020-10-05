import UIKit

enum Theme: String, CaseIterable {
    case pear, blueberry, orange, raspberry

    private static var `default`: Self {
        .pear
    }

    static var selected: Self {
        // Return default theme in case the selected theme id is not set yet.
        guard let themeIdentifier = UserDefaults.standard.string(forKey: Key.selectedTheme) else {
            return .default
        }
        // Return default theme in case the selected theme can not be used to
        // create an `Theme`, e.g. when a `Theme` was removed.
        guard let theme = Theme(rawValue: themeIdentifier) else {
            return .default
        }

        return theme
    }

    var name: String {
        "Theme.\(self.rawValue.capitalized).Name".localized
    }

    var isSelected: Bool {
        self == AppDelegate.shared.theme
    }
}

// MARK: - Colors

extension Theme {
    var backgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return .secondarySystemBackground
        } else {
            return .white
        }
    }

    var primaryContentColor: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .darkGray
        }
    }

    var secondaryContentColor: UIColor {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .lightGray
        }
    }

    var tertiaryContentColor: UIColor {
        if #available(iOS 13.0, *) {
            return .tertiaryLabel
        } else {
            return .lightGray
        }
    }

    var interactionColor: UIColor {
        UIColor(named: "\(self.rawValue.capitalized).Corporate")!
    }

    var onInteractionColor: UIColor {
        .white
    }
}

// MARK: - Fonts

extension Theme {
    var activityIndicatorFont: UIFont {
        .preferredFont(forTextStyle: .caption2)
    }

    var buttonFont: UIFont {
        .preferredFont(forTextStyle: .callout)
    }

    var disclaimerFont: UIFont {
        .preferredFont(forTextStyle: .caption1)
    }

    var headingFont: UIFont {
        .preferredFont(forTextStyle: .title1)
    }

    var locationFont: UIFont {
        .preferredFont(forTextStyle: .body)
    }

    var speedFont: UIFont {
        .systemFont(ofSize: 92.0, weight: .thin)
    }

    var swipeInfoFont: UIFont {
        .preferredFont(forTextStyle: .caption2)
    }

    var textFont: UIFont {
        .preferredFont(forTextStyle: .subheadline)
    }

    var unitFont: UIFont {
        .preferredFont(forTextStyle: .title2)
    }
}
