import Foundation

struct Speed {
    let speed: Double
    let unit: Unit

    init(speed: Double, unit: Unit) {
        self.speed = (speed > 1.0) ? speed * unit.factor : 0
        self.unit = unit
    }

    var fillment: Double {
        return ((speed * 100) / Double(unit.maximumSpeed)) * 0.01
    }

    var localizedString: String {
        return String(format: unit.displayFormat, speed)
    }
}
