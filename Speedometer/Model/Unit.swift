import Foundation

enum Unit: String, CaseIterable {
    case kilometersPerHour, milesPerHour, metersPerSecond, knots

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

    var next: Unit {
        let units = Unit.allCases

        let index = units.firstIndex(of: self)! + 1
        guard index < units.count else {
            return units.first!
        }

        return units[index]
    }
}
