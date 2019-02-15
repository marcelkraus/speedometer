import Foundation

struct AppConfig {
    struct UserDefaultsKey {
        static let appStartCounter = "app_start_counter"
        static let unit = "unit"
    }
    struct Default {
        static let unit = Locale.current.usesMetricSystem ? Unit.kilometersPerHour.rawValue : Unit.milesPerHour.rawValue
    }
    static let minimumHorizontalAccuracy = 60
    static let speedStringFormat = "%.0f"
}
