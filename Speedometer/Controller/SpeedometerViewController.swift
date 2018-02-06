import CoreLocation
import UIKit

class SpeedometerViewController: UIViewController {
    private let locationManager: CLLocationManager

    private var unit: Unit
    private var speed = 0.0 {
        didSet {
            speedLabel.text = speed(speed)
        }
    }

    // MARK: - Controller Lifecycle

    init(locationManager: CLLocationManager, unit: Unit) {
        self.locationManager = locationManager
        self.unit = unit

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()
        setupUnitLabel()
    }

    // MARK: - Outlets & Actions

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var informationButton: UIButton!

    @IBAction func showImprint(_ sender: UIButton) {
        present(ImprintViewController(unit: unit), animated: true, completion: nil)
    }
}

// MARK: - CLLocationManagerDelegate

extension SpeedometerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        speed = locations.last?.speed ?? 0
    }
}

// MARK: - Private Methods

private extension SpeedometerViewController {
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    func setupUnitLabel() {
        unitLabel.text = unit.abbreviation
    }

    func speed(_ speed: Double) -> String {
        return String(format: "%01.0f", speed > 1.0 ? speed * unit.factor : 0)
    }
}
