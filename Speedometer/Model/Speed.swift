import Foundation

struct Speed {
    let speed: Double
    let unit: Unit

    private var convertedSpeed: Float {
        return Float(speed > 1.0 ? speed * unit.factor : 0)
    }

    var asString: String {
        return String(format: Configuration.speedStringFormat, convertedSpeed)
    }

    var limitIsExceeded: Bool {
        let currentSpeedLimit = UserDefaults.standard.float(forKey: Configuration.currentSpeedLimitDefaultsKey)
        guard currentSpeedLimit > 0, convertedSpeed > currentSpeedLimit else {
            return false
        }

        return true
    }
}
