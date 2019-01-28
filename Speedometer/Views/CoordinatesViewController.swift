import CoreLocation
import UIKit

class CoordinatesViewController: UIViewController {
    private let locationManager = CLLocationManager()

    private var coordinates: Coordinates? {
        didSet {
            guard let coordinates = coordinates else {
                return
            }

            coordinatesLabel.text = "\(coordinates.formatted.latitude)\n\(coordinates.formatted.longitude)"
        }
    }

    @IBOutlet weak var coordinatesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension CoordinatesViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        coordinates = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}
