enum Unit {
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
