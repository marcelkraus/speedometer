import Foundation

enum Unit: String, CaseIterable {
    case kilometersPerHour = "km/h"
    case milesPerHour = "mph"
    case metersPerSecond = "m/s"
    case knots = "kn"
    case split500 = "min./500m"

    static var `default`: Unit {
        Locale.current.usesMetricSystem ? Unit.kilometersPerHour : Unit.milesPerHour
    }

    static var selected: Unit {
        // Return default unit in case the selected unit id can not be fetched
        // from UserDefaults or still contains an Int (e.g. fauly migration).
        guard let selectedUnit = UserDefaults.standard.string(forKey: Key.selectedUnit) else {
            return .default
        }

        // Return default unit in case the selected unit can not be used to
        // create an `Unit`, e.g. when an `Unit` was removed.
        guard let unit = Unit(rawValue: selectedUnit) else {
            return .default
        }

        return unit
    }

    var next: Unit {
        let units = Unit.allCases

        let index = units.firstIndex(of: self)! + 1
        let unit = (index < units.count) ? units[index] : units.first!
        UserDefaults.standard.set(unit.rawValue, forKey: Key.selectedUnit)

        return unit
    }

    func calculateSpeed(for speedProvidedByDevice: Double) -> Double {
        // There is a minimum of 0.5 m/s needed before the app will return a
        // calculated speed.
        guard speedProvidedByDevice > 0.5 else {
            return 0
        }

        switch self {
        case .kilometersPerHour:
            return speedProvidedByDevice * 3.6
        case .milesPerHour:
            return speedProvidedByDevice * 2.23694
        case .metersPerSecond:
            return speedProvidedByDevice * 1.0
        case .knots:
            return speedProvidedByDevice * 1.944
        case .split500:
            return (500 / (speedProvidedByDevice * 60)) * 60
        }
    }

    func calculcateFillment(for speedProvidedByDevice: Double) -> Double {
        let maximumFillment = self == .split500 ? 7.00000 : 66.66667
        let fillment = ((speedProvidedByDevice * 100) / maximumFillment) * 0.01

        guard fillment > 0.0 else {
            return  0.0
        }

        guard fillment < 1.0 else {
            return 1.0
        }

        return fillment
    }

    func localizedString(for speed: Double) -> String {
        if (self == .split500) {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .positional
            formatter.allowedUnits = [.minute, .second]
            formatter.zeroFormattingBehavior = [.pad]

            var string = formatter.string(from: speed) ?? "00:00"

            // Hack to remove the first of two leading zeros for the minute
            if string.count == 5 && string.first == "0" {
                string.remove(at: string.startIndex)
            }

            return string
        }

        return String(format: "%.0f", speed)
    }
}
