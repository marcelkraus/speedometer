import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double

    var formatted: (latitude: String, longitude: String) {
        let latDegrees = abs(Int(latitude))
        let latMinutes = abs(Int((latitude * 3600).truncatingRemainder(dividingBy: 3600) / 60))
        let latSeconds = Double(abs((latitude * 3600).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60)))

        let lonDegrees = abs(Int(longitude))
        let lonMinutes = abs(Int((longitude * 3600).truncatingRemainder(dividingBy: 3600) / 60))
        let lonSeconds = Double(abs((longitude * 3600).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60) ))

        return (
            String(format: "%d° %d' %.0f\" %@", latDegrees, latMinutes, latSeconds, latitude >= 0 ? "SpeedometerViewController.Orientation.North".localized : "SpeedometerViewController.Orientation.South".localized),
            String(format: "%d° %d' %.0f\" %@", lonDegrees, lonMinutes, lonSeconds, longitude >= 0 ? "SpeedometerViewController.Orientation.East".localized : "SpeedometerViewController.Orientation.West".localized)
        )
    }
}
