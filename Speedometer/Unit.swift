enum Unit: String {

    case kilometersPerHour = "km/h"
    case metersPerSecond = "m/s"
    case milesPerHour = "mph"

    var factor: Double {
        switch self {
        case .kilometersPerHour:
            return 3.6
        case .metersPerSecond:
            return 1
        case .milesPerHour:
            return 2.23694
        }
    }

}
