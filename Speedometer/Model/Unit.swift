import Foundation

enum Unit: Int, CaseIterable {
    private enum Keys {
        static let selectedUnit = "unit"
    }

    case kilometersPerHour = 1, milesPerHour, metersPerSecond, knots, split500

    static func selected(usesMetricSystem: Bool = Locale.current.usesMetricSystem) -> Unit {
        let defaultUnit: Unit = usesMetricSystem ? Unit.kilometersPerHour : Unit.milesPerHour
        let selectedUnit = UserDefaults.standard.integer(forKey: Keys.selectedUnit)

        return Unit(rawValue: selectedUnit) ?? defaultUnit
    }

    var next: Unit {
        let units = Unit.allCases

        let index = units.firstIndex(of: self)! + 1
        let unit = (index < units.count) ? units[index] : units.first!
        UserDefaults.standard.set(unit.rawValue, forKey: Keys.selectedUnit)

        return unit
    }

    var abbreviation: String {
        switch self {
        case .kilometersPerHour:
            return "km/h"
        case .milesPerHour:
            return "mph"
        case .metersPerSecond:
            return "m/s"
        case .knots:
            return "kn"
        case .split500:
            return "min./500m"
        }
    }

    func calculate(for speed: Double) -> Double {
        // There is a minimum of 0.5 m/s needed before the app will return a
        // calculated speed.
        guard speed > 0.5 else {
            return 0
        }

        switch self {
        case .kilometersPerHour:
            return speed * 3.6
        case .milesPerHour:
            return speed * 2.23694
        case .metersPerSecond:
            return speed * 1.0
        case .knots:
            return speed * 1.944
        case .split500:
            return 500 / (speed * 60)
        }
    }

    func fillment(for speed: Double) -> Double {
        return ((speed * 100) / maximumSpeed) * 0.01
    }

    func format(for speed: Double) -> String {
        let format = self == .split500 ? "%.2f": "%.0f"

        return String(format: format, speed)
    }

    private var maximumSpeed: Double {
        switch self {
        case .kilometersPerHour:
            return 240.0
        case .milesPerHour:
            return 160.0
        case .metersPerSecond:
            return 65.0
        case .knots:
            return 125.0
        case .split500:
            return 0
        }
    }
}
