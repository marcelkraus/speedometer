import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    private var theme = Theme.light
    private var unit = Unit.kilometersPerHour
    private let locationManager = CLLocationManager()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme == .dark ? .lightContent : .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initThemeRecognizer()
        initUnitRecognizer()

        initLocationManager()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateDisplay(unit: unit, speed: locationManager.location?.speed ?? 0)
    }

}

private extension ViewController {

    enum Theme {
        case dark, light
    }

    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        locationManager.startUpdatingLocation()
    }

    func initThemeRecognizer() {
        let themeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(toggleTheme))
        themeRecognizer.direction = [.left, .right]
        view.addGestureRecognizer(themeRecognizer)
    }

    func initUnitRecognizer() {
        let unitRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleUnit))
        view.addGestureRecognizer(unitRecognizer)
    }

    func updateDisplay(unit: Unit, speed: Double) {
        let speed = speed > 1.0 ? speed * unit.factor : 0

        unitLabel.text = unit.rawValue
        speedLabel.text = String(format: "%03.0f", speed)
    }

    @objc func toggleTheme() {
        theme = theme == .dark ? .light : .dark

        switch theme {
        case .dark:
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            speedLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            unitLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .light:
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            speedLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            unitLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }

        setNeedsStatusBarAppearanceUpdate()
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
