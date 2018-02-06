import Foundation

// Global list of available units in the desired order, should be refactored
let units = [Unit.milesPerHour, Unit.kilometersPerHour, Unit.metersPerSecond]

enum Unit: String {
    static let UserDefaultsKey = "unit"

    case kilometersPerHour, metersPerSecond, milesPerHour

    var abbreviation: String {
        switch self {
        case .kilometersPerHour:
            return "km/h"
        case .metersPerSecond:
            return "m/s"
        case .milesPerHour:
            return "mph"
        }
    }

    var factor: Double {
        switch self {
        case .kilometersPerHour:
            return 3.6
        case .metersPerSecond:
            return 1.0
        case .milesPerHour:
            return 2.23694
        }
    }
}
