import Foundation

enum Distance {
    private static let minimumSpeed = 0.5

    static var totalMeters: Double {
        get { UserDefaults.standard.double(forKey: Key.tripDistance) }
        set { UserDefaults.standard.set(newValue, forKey: Key.tripDistance) }
    }

    static func accumulate(deltaMeters: Double, speed: Double) {
        guard speed > minimumSpeed, deltaMeters > 0 else {
            return
        }

        totalMeters += deltaMeters
    }

    static func reset() {
        totalMeters = 0
    }

    static func localizedString(for unit: Unit) -> String {
        let distance = convertedDistance(for: unit)

        switch unit {
        case .kilometersPerHour:
            return String(format: "%.1f km", distance)
        case .milesPerHour:
            return String(format: "%.1f mi", distance)
        case .metersPerSecond, .split500:
            return String(format: "%.0f m", distance)
        case .knots:
            return String(format: "%.1f nm", distance)
        }
    }

    static func convertedDistance(for unit: Unit) -> Double {
        switch unit {
        case .kilometersPerHour:
            return totalMeters / 1000.0
        case .milesPerHour:
            return totalMeters / 1609.344
        case .metersPerSecond, .split500:
            return totalMeters
        case .knots:
            return totalMeters / 1852.0
        }
    }
}
