import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    var theme: Theme {
        return themes[themeIndex]
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme.statusBarAppearance
    }

    private let themes = ThemeLoader().loadThemes()
    private var themeIndex = 0 {
        didSet {
            view.backgroundColor = theme.backgroundColor
            speedLabel.textColor = theme.speedLabelColor
            unitLabel.textColor = theme.unitLabelColor
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    private let locationManager = CLLocationManager()
    private var unit = Unit.kilometersPerHour

    override func viewDidLoad() {
        super.viewDidLoad()

        configureThemeRecognizers()
        configureUnitRecognizer()

        initLocationManager()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateDisplay(unit: unit, speed: locationManager.location?.speed ?? 0)
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
        let previousThemeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(previousTheme))
        previousThemeGestureRecognizer.numberOfTouchesRequired = 2
        previousThemeGestureRecognizer.direction = .up
        view.addGestureRecognizer(previousThemeGestureRecognizer)

        let nextThemeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(nextTheme))
        nextThemeGestureRecognizer.numberOfTouchesRequired = 2
        nextThemeGestureRecognizer.direction = .down
        view.addGestureRecognizer(nextThemeGestureRecognizer)
    }

    func configureUnitRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleUnit))
        view.addGestureRecognizer(gestureRecognizer)
    }

    func updateDisplay(unit: Unit, speed: Double) {
        let speed = speed > 1.0 ? speed * unit.factor : 0

        unitLabel.text = unit.rawValue
        speedLabel.text = String(format: "%03.0f", speed)
    }

    @objc func previousTheme() {
        guard themeIndex-1 >= 0 else {
            return
        }

        themeIndex -= 1
    }

    @objc func nextTheme() {
        guard themeIndex+1 < themes.count else {
            return
        }

        themeIndex += 1
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

        updateDisplay(unit: unit, speed: locationManager.location?.speed ?? 0)
    }

}
