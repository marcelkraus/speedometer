import UIKit

extension UIFont {
    static var activityIndicator: UIFont {
        return .preferredFont(forTextStyle: .caption2)
    }

    static var button: UIFont {
        return .preferredFont(forTextStyle: .title2)
    }

    static var coordinates: UIFont {
        return .preferredFont(forTextStyle: .body)
    }

    static var heading: UIFont {
        return .preferredFont(forTextStyle: .title1)
    }

    static var speed: UIFont {
        return .systemFont(ofSize: 120.0, weight: .thin)
    }

    static var swipeInfo: UIFont {
        return .preferredFont(forTextStyle: .caption2)
    }

    static var text: UIFont {
        return .preferredFont(forTextStyle: .subheadline)
    }

    static var unit: UIFont {
        return .preferredFont(forTextStyle: .title2)
    }
}
