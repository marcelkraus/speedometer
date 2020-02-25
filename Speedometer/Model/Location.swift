import Foundation

struct Location {
    let latitude: Double
    let longitude: Double

    var localizedString: (latitude: String, longitude: String) {
        let latitudeDegrees = abs(Int(latitude))
        let latitudeMinutes = abs(Int((latitude * 3600).truncatingRemainder(dividingBy: 3600) / 60))
        let latitudeSeconds = Double(abs((latitude * 3600).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60)))

        let longitudeDegrees = abs(Int(longitude))
        let longitudeMinutes = abs(Int((longitude * 3600).truncatingRemainder(dividingBy: 3600) / 60))
        let longitudeSeconds = Double(abs((longitude * 3600).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60) ))

        return (
            String(format: "%d° %d' %.0f\" %@", latitudeDegrees, latitudeMinutes, latitudeSeconds, latitude >= 0 ? "SpeedometerViewController.Orientation.North".localized : "SpeedometerViewController.Orientation.South".localized),
            String(format: "%d° %d' %.0f\" %@", longitudeDegrees, longitudeMinutes, longitudeSeconds, longitude >= 0 ? "SpeedometerViewController.Orientation.East".localized : "SpeedometerViewController.Orientation.West".localized)
        )
    }
}
