import Foundation

struct Speed {
    let speed: Float
    let unit: Unit
    let speedLimit: Float

    init(speed: Double, unit: Unit, speedLimit: Float) {
        self.speed = Float(speed > 1.0 ? speed * unit.factor : 0)
        self.unit = unit
        self.speedLimit = speedLimit
    }

    var asString: String {
        return String(format: Configuration.speedStringFormat, speed)
    }

    var limitIsExceeded: Bool {
        guard speedLimit > 0, speed > speedLimit else {
            return false
        }

        return true
    }
}
