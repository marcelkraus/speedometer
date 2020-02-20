import Foundation

enum Unit: String, CaseIterable {
    case kilometersPerHour = "km/h"
    case milesPerHour = "mph"
    case metersPerSecond = "m/s"
    case knots = "kn"
    case split500 = "min./500m"

    static var selected: Unit {
        let selectedUnit = UserDefaults.standard.string(forKey: Key.selectedUnit)!

        // This should only happen if there was a migration error and the
        // NSUserDefaults still contains an Int, we then return the first Unit
        // defined.
        guard Int(selectedUnit) == nil else {
            return Unit.allCases.first!
        }

        return Unit(rawValue: selectedUnit)!
    }

    var next: Unit {
        let units = Unit.allCases

        let index = units.firstIndex(of: self)! + 1
        let unit = (index < units.count) ? units[index] : units.first!
        UserDefaults.standard.set(unit.rawValue, forKey: Key.selectedUnit)

        return unit
    }

    func calculateSpeed(for deviceValue: Double) -> Double {
        // There is a minimum of 0.5 m/s needed before the app will return a
        // calculated speed.
        guard deviceValue > 0.5 else {
            return 0
        }

        switch self {
        case .kilometersPerHour:
            return deviceValue * 3.6
        case .milesPerHour:
            return deviceValue * 2.23694
        case .metersPerSecond:
            return deviceValue * 1.0
        case .knots:
            return deviceValue * 1.944
        case .split500:
            return 500 / (deviceValue * 60)
        }
    }

    func calculcateFillment(for deviceValue: Double) -> Double {
        let maximumFillment = self == .split500 ? 7.00000 : 66.66667
        let fillment = ((deviceValue * 100) / maximumFillment) * 0.01

        guard fillment > 0.0 else {
            return  0.0
        }

        guard fillment < 1.0 else {
            return 1.0
        }

        return fillment
    }

    func localizedString(for speed: Double) -> String {
        let format = self == .split500 ? "%.2f": "%.0f"

        return String(format: format, speed)
    }
}
