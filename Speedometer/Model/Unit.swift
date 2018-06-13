import Foundation

// Global list of available units in the desired order, should be refactored
let units = [Unit.milesPerHour, Unit.kilometersPerHour, Unit.metersPerSecond, Unit.knots]

enum Unit: String {
    case kilometersPerHour, knots, metersPerSecond, milesPerHour

    var abbreviation: String {
        switch self {
        case .kilometersPerHour:
            return "km/h"
        case .knots:
            return "kn"
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
        case .knots:
            return 1.944
        case .metersPerSecond:
            return 1.0
        case .milesPerHour:
            return 2.23694
        }
    }

    var maximumSpeed: Int {
        return Int(self.factor * 66.7)
    }

    var speedLimitSliderSteps: Int {
        switch self {
        case .metersPerSecond:
            return 1
        default:
            return 5
        }
    }
}
