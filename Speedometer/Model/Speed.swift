import Foundation

struct Speed {
    let speed: Double
    let unit: Unit

    init(speed: Double, unit: Unit) {
        self.speed = (speed > 0.5) ? speed * unit.factor : 0
        self.unit = unit
    }

    init(speed: Speed, unit: Unit) {
        self.speed = (speed.speed / speed.unit.factor) * unit.factor
        self.unit = unit
    }

    var roundedSpeed: Int {
        return Int(round(speed))
    }

    var asString: String {
        return String(format: Configuration.speedStringFormat, speed)
    }

    var asStringWithUnit: String {
        return "\(asString) \(unit.abbreviation)"
    }
}
