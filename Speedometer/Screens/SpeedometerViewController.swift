import CoreLocation
import UIKit

class SpeedometerViewController: UIViewController {
    static let speedStringFormat = "%.0f"
    private static let speedPlaceholderLabel = "…"
    private static let speedPlaceholderAnimationDuration = 0.5

    private let locationManager: CLLocationManager

    private var unit: Unit
    private var speedValue: Double? {
        didSet {
            guard let speedValue = speedValue else { return }

            let convertedSpeed = convertSpeed(speedValue)
            speedLabel.text = String(format: "%01.0f", convertedSpeed)

            let maximumSpeedWithoutWarning = UserDefaults.standard.float(forKey: Speed.currentSpeedLimitKey)
            guard maximumSpeedWithoutWarning > 0, Float(convertedSpeed) > maximumSpeedWithoutWarning else {
                speedLabel.textColor = nil
                return
            }

            speedLabel.textColor = UIColor(red: 0.6196, green: 0, blue: 0, alpha: 1.0)
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

        speedLabel.text = SpeedometerViewController.speedPlaceholderLabel
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
        if speedLabel.text == SpeedometerViewController.speedPlaceholderLabel {
            UIView.transition(with: speedLabel, duration: SpeedometerViewController.speedPlaceholderAnimationDuration, options: .transitionCrossDissolve, animations: { [weak self] in
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

    func convertSpeed(_ speed: Double) -> Double {
        return speed > 1.0 ? speed * unit.factor : 0
    }
}
