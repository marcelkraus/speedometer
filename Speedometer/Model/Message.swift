import Foundation

enum Message: String {
    case locationAuthorizationStatusDenied = "LocationAuthorizationStatusDenied"
    case locationAuthorizationStatusRestricted = "LocationAuthorizationStatusRestricted"
    case onboarding = "Onboarding"

    var heading: String {
        return "Message.\(rawValue).Heading".localized
    }

    var text: String {
        return "Message.\(rawValue).Text".localized
    }
}
