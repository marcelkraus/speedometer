import CoreLocation
import UIKit

class CoordinatesViewController: UIViewController {

    // MARK: - Properties

    private let locationManager = CLLocationManager()

    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            statusLabel.text = "CoordinatesViewController.Status".localized
        }
    }

    private var coordinates: Coordinates? {
        didSet {
            guard let coordinates = coordinates else {
                return
            }

            coordinatesLabel.text = "\(coordinates.formatted.latitude)\n\(coordinates.formatted.longitude)"
        }
    }

    // MARK: - Outlets & Actions

    @IBOutlet weak var coordinatesLabel: UILabel!

    // MARK: - View Controller Lifecycle

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
