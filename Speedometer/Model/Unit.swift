import Foundation

enum Unit: Int, CaseIterable {
    private enum Keys {
        static let selectedUnit = "unit"
    }

    case kilometersPerHour = 1, milesPerHour, metersPerSecond, knots

    static func selected(usesMetricSystem: Bool = Locale.current.usesMetricSystem) -> Unit {
        let selectedUnit = UserDefaults.standard.integer(forKey: Keys.selectedUnit)
        let defaultUnit: Unit = usesMetricSystem ? Unit.kilometersPerHour : Unit.milesPerHour

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
        }
    }

    var factor: Double {
        switch self {
        case .kilometersPerHour:
            return 3.6
        case .milesPerHour:
            return 2.23694
        case .metersPerSecond:
            return 1.0
        case .knots:
            return 1.944
        }
    }

    var maximumSpeed: Int {
        return Int(self.factor * 66.7)
    }
}
