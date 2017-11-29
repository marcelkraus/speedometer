import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private let themeManager = ThemeManager()

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themeManager.current.statusBarAppearance
    }

    private var unit = Unit.kilometersPerHour

    override func viewDidLoad() {
        super.viewDidLoad()

        configureThemeRecognizers()
        configureUnitRecognizer()
        initLocationManager()
        updateThemeColors()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateLabels(unit: unit, speed: locationManager.location?.speed ?? 0)
    }

}

private extension ViewController {

    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        locationManager.startUpdatingLocation()
    }

    func configureThemeRecognizers() {
        let nextThemeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(nextTheme))
        nextThemeGestureRecognizer.numberOfTouchesRequired = 2
        nextThemeGestureRecognizer.direction = .up
        view.addGestureRecognizer(nextThemeGestureRecognizer)

        let previousThemeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(previousTheme))
        previousThemeGestureRecognizer.numberOfTouchesRequired = 2
        previousThemeGestureRecognizer.direction = .down
        view.addGestureRecognizer(previousThemeGestureRecognizer)
    }

    func configureUnitRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleUnit))
        view.addGestureRecognizer(gestureRecognizer)
    }

    func updateThemeColors() {
        view.backgroundColor = themeManager.current.backgroundColor
        speedLabel.textColor = themeManager.current.speedLabelColor
        unitLabel.textColor = themeManager.current.unitLabelColor
        setNeedsStatusBarAppearanceUpdate()
    }

    func updateLabels(unit: Unit, speed: Double) {
        let speed = speed > 1.0 ? speed * unit.factor : 0

        unitLabel.text = unit.rawValue
        speedLabel.text = String(format: "%01.0f", speed)
    }

    @objc func nextTheme() {
        themeManager.next()

        updateThemeColors()
    }

    @objc func previousTheme() {
        themeManager.previous()

        updateThemeColors()
    }

    @objc func toggleUnit() {
        switch unit {
        case .kilometersPerHour:
            unit = .milesPerHour
        case .milesPerHour:
            unit = .metersPerSecond
        case .metersPerSecond:
            unit = .kilometersPerHour
        }

        updateLabels(unit: unit, speed: locationManager.location?.speed ?? 0)
    }

}
