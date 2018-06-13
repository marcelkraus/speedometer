import CoreLocation
import UIKit

class SpeedometerViewController: UIViewController {
    private let locationManager: CLLocationManager

    private var speed: Speed? {
        didSet {
            guard let speed = speed else {
                return
            }

            speedLabel.text = speed.asString

            speedLabel.textColor = nil
            if let speedLimit = speedLimit, speed.roundedSpeed > speedLimit.roundedSpeed {
                speedLabel.textColor = UIColor(red: 0.6196, green: 0, blue: 0, alpha: 1.0)
            }
        }
    }

    private var speedLimit: Speed? {
        didSet {
            guard let speedLimit = speedLimit else {
                resetSpeedLimitLabels()

                return
            }

            UserDefaults.standard.set(speedLimit.asString, forKey: Configuration.currentSpeedLimitDefaultsKey)
            speedLimitLabel.text = "\("SpeedometerViewController.SpeedLimit.CurrentSpeedLimit".localized) \(speedLimit.asStringWithUnit)"
            speedLimitDescriptionLabel.text = "SpeedometerViewController.SpeedLimit.TapToReleaseSpeedLimit".localized
        }
    }

    private var unit: Unit {
        didSet {
            UserDefaults.standard.removeObject(forKey: Configuration.currentSpeedLimitDefaultsKey)

            unitLabel.text = unit.abbreviation
            UserDefaults.standard.set(unit.rawValue, forKey: Configuration.currentUnitDefaultsKey)
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

        configureView()
        configureLocationManager()
    }

    // MARK: - Outlets & Actions

    @IBOutlet weak var inaccurateSignalIndicatorLabel: UILabel!
    @IBOutlet weak var loadingStackView: UIStackView!
    @IBOutlet weak var speedStackView: UIStackView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var speedLimitStackView: UIStackView!
    @IBOutlet weak var speedLimitLabel: UILabel! {
        didSet {

        }
    }
    @IBOutlet weak var speedLimitDescriptionLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl! {
        didSet {
            unitSegmentedControl.removeAllSegments()
            units.enumerated().forEach { (index, unit) in
                unitSegmentedControl.insertSegment(withTitle: unit.abbreviation, at: index, animated: false)
            }

            unitSegmentedControl.selectedSegmentIndex = units.index(where: { $0.abbreviation == unit.abbreviation }) ?? 0
        }
    }

    @IBAction func presentSettings(_ sender: UIButton) {
        let imprintViewController = ImprintViewController()
        imprintViewController.modalPresentationStyle = .overCurrentContext
        imprintViewController.modalTransitionStyle = .crossDissolve

        present(imprintViewController, animated: true, completion: nil)
    }

    @IBAction func updateUnit(_ sender: UISegmentedControl) {
        updateUnit(units[sender.selectedSegmentIndex])
    }
}

// MARK: - CLLocationManagerDelegate

extension SpeedometerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let speedValue = locations.last?.speed, let horizontalAccuracy = locations.last?.horizontalAccuracy, horizontalAccuracy <= Configuration.minimumHorizontalAccuracy else {
            setDisplayMode(to: .loadingIndicator)

            return
        }

        if speedStackView.isHidden {
            setDisplayMode(to: .speed)
        }

        speed = Speed(speed: speedValue, unit: unit)
    }
}

// MARK: - Private Methods

private extension SpeedometerViewController {
    enum DisplayMode {
        case loadingIndicator
        case speed
    }

    func configureView() {
        setDisplayMode(to: .loadingIndicator)

        inaccurateSignalIndicatorLabel.text = "SpeedometerViewController.Indicator".localized
        unitLabel.text = unit.abbreviation
        resetSpeedLimitLabels()

        let speedLimitTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.updateSpeedLimit(sender:)))
        speedStackView.addGestureRecognizer(speedLimitTapGesture)

        StoreReviewHelper.askForReview()
    }

    func resetSpeedLimitLabels() {
        speedLimitLabel.text = "SpeedometerViewController.SpeedLimit.NoSpeedLimit".localized
        speedLimitDescriptionLabel.text = "SpeedometerViewController.SpeedLimit.TapToSetSpeedLimit".localized
    }

    func setDisplayMode(to displayMode: DisplayMode) {
        switch displayMode {
        case .loadingIndicator:
            loadingStackView.isHidden = false
            speedStackView.isHidden = true
            speedLimitStackView.isHidden = true
        case .speed:
            loadingStackView.isHidden = true
            speedStackView.isHidden = false
            speedLimitStackView.isHidden = false
        }
    }

    func updateUnit(_ unit: Unit) {
        self.unit = unit

        guard let speedLimit = speedLimit else {
            return
        }

        self.speedLimit = Speed(speed: speedLimit, unit: unit)
    }

    @objc func updateSpeedLimit(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            guard speedLimit == nil else {
                speedLimit = nil

                return
            }

            speedLimit = speed
        }
    }

    func configureLocationManager() {
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}
