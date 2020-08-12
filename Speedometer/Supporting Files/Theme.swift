import UIKit

enum Theme {
    case `default`
}

// MARK: - Colors

extension Theme {
    var activityIndicatorColor: UIColor {
        .darkGray
    }

    var backgroundColor: UIColor {
        .white
    }

    var circularViewColor: UIColor {
        .lightGray
    }

    var corporateColor: UIColor {
        UIColor(red: 0.012, green: 0.569, blue: 0.576, alpha: 1.00)
    }

    var locationColor: UIColor {
        .darkGray
    }

    var speedColor: UIColor {
        .black
    }

    var swipeInfoColor: UIColor {
        .darkGray
    }

    var primaryTextColor: UIColor {
        .black
    }

    var textOnCorporateColor: UIColor {
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
