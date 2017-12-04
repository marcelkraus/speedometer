import CoreLocation
import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var speedLabel: UILabel!
    @IBOutlet private weak var unitLabel: UILabel!

    private let locationManager = CLLocationManager()
    private let themeManager = ThemeManager()

    private var unit = Unit.kilometersPerHour
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themeManager.current.statusBarStyle
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initLocationManager()
        configureGestureRecognizers()
        updateThemeColors()
    }
}

extension ViewController: CLLocationManagerDelegate {

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

    func configureGestureRecognizers() {
        let nextThemeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(nextTheme))
        nextThemeGestureRecognizer.numberOfTouchesRequired = 2
        nextThemeGestureRecognizer.direction = .up
        view.addGestureRecognizer(nextThemeGestureRecognizer)

        let previousThemeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(previousTheme))
        previousThemeGestureRecognizer.numberOfTouchesRequired = 2
        previousThemeGestureRecognizer.direction = .down
        view.addGestureRecognizer(previousThemeGestureRecognizer)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleUnit))
        view.addGestureRecognizer(gestureRecognizer)
    }

    func updateThemeColors() {
        view.backgroundColor = themeManager.current.color.background
        speedLabel.textColor = themeManager.current.color.speedLabel
        unitLabel.textColor = themeManager.current.color.unitLabel
        setNeedsStatusBarAppearanceUpdate()
    }

    func updateLabels(unit: Unit, speed: Double) {
        let speed = speed > 1.0 ? speed * unit.data.factor : 0

        unitLabel.text = unit.data.abbreviation
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
