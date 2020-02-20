import Foundation

enum Message {
    case locationAuthorizationStatusDenied, locationAuthorizationStatusRestricted, onboarding

    var heading: String {
        switch self {
        case .locationAuthorizationStatusDenied:
            return "ParagraphViewController.LocationAuthorizationStatusRestricted.Heading".localized
        case .locationAuthorizationStatusRestricted:
            return "ParagraphViewController.LocationAuthorizationStatusDenied.Heading".localized
        case .onboarding:
            return "ParagraphViewController.Onboarding.Heading".localized
        }
    }

    var text: String {
        switch self {
        case .locationAuthorizationStatusDenied:
            return "ParagraphViewController.LocationAuthorizationStatusRestricted.Text".localized
        case .locationAuthorizationStatusRestricted:
            return "ParagraphViewController.LocationAuthorizationStatusDenied.Text".localized
        case .onboarding:
            return "ParagraphViewController.Onboarding.Text".localized
        }
    }
}
