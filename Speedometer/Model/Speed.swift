import Foundation

struct Speed {
    let speed: Double
    let unit: Unit

    init(of value: Double, as unit: Unit) {
        self.unit = unit
        self.speed = unit.calculate(for: value)
    }

    var fillment: Double {
        return ((speed * 100) / unit.maximumSpeed) * 0.01
    }

    var localizedString: String {
        return String(format: unit.displayFormat, speed)
    }
}
