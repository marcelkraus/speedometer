enum Unit {
    case kilometersPerHour, metersPerSecond, milesPerHour

    var data: (abbreviation: String, factor: Double) {
        switch self {
        case .kilometersPerHour:
            return (abbreviation: "km/h", factor: 3.6)
        case .metersPerSecond:
            return (abbreviation: "m/s", factor: 1.0)
        case .milesPerHour:
            return (abbreviation: "mph", factor: 2.23694)
        }
    }

    mutating func toggle() {
        switch self {
        case .kilometersPerHour:
            self = .milesPerHour
        case .milesPerHour:
            self = .metersPerSecond
        case .metersPerSecond:
            self = .kilometersPerHour
        }
    }
}
