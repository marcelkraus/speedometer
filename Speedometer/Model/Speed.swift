import Foundation

struct Speed {
    static let stringFormatForSpeed = "%.0f"
    static let currentSpeedLimitKey = "speed"

    let speed: Double
    let unit: Unit

    private var convertedSpeed: Float {
        return Float(speed > 1.0 ? speed * unit.factor : 0)
    }

    var asString: String {
        return String(format: Speed.stringFormatForSpeed, convertedSpeed)
    }

    var limitIsExceeded: Bool {
        let currentSpeedLimit = UserDefaults.standard.float(forKey: Speed.currentSpeedLimitKey)
        guard currentSpeedLimit > 0, convertedSpeed > currentSpeedLimit else {
            return false
        }

        return true
    }
}
