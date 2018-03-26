import CoreLocation
import UIKit

class SpeedometerViewController: UIViewController {
    private static let PlaceholderLabel = "…"
    private static let PlaceholderAnimationDuration = 0.5

    private let locationManager: CLLocationManager

    private var unit: Unit
    private var speedValue: Double? {
        didSet {
            guard let speedValue = speedValue else {
                return
            }

            speedLabel.text = speed(speedValue)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        speedLabel.text = SpeedometerViewController.PlaceholderLabel
    }

    // MARK: - Outlets & Actions

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var informationButton: UIButton!

    @IBAction func closeSettings(_ sender: UIButton) {
        present(SettingsViewController(unit: unit), animated: true, completion: nil)
    }
}

// MARK: - CLLocationManagerDelegate

extension SpeedometerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if speedLabel.text == SpeedometerViewController.PlaceholderLabel {
            UIView.transition(with: speedLabel, duration: SpeedometerViewController.PlaceholderAnimationDuration, options: .transitionCrossDissolve, animations: { [weak self] in
                self?.speedValue = locations.last?.speed ?? 0
            }, completion: nil)
        }

        speedValue = locations.last?.speed ?? 0
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
