import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    private let themes = LocalThemeLoader.load()
    private let locationManager = CLLocationManager()

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme.statusBarAppearance
    }

    private var theme: Theme {
        didSet {
            configureTheme()
        }
    }
    private var unit = Unit.kilometersPerHour

    required init?(coder aDecoder: NSCoder) {
        theme = themes.first!

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureThemeRecognizers()
        configureUnitRecognizer()
        initLocationManager()
        configureTheme()
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

    func configureTheme() {
        view.backgroundColor = theme.backgroundColor
        speedLabel.textColor = theme.speedLabelColor
        unitLabel.textColor = theme.unitLabelColor
        setNeedsStatusBarAppearanceUpdate()
    }

    func updateDisplay(unit: Unit, speed: Double) {
        let speed = speed > 1.0 ? speed * unit.factor : 0

        unitLabel.text = unit.rawValue
        speedLabel.text = String(format: "%03.0f", speed)
    }

    @objc func nextTheme() {
        guard let index = themes.index(of: theme)?.advanced(by: +1), themes.indices.contains(index) else {
            return
        }

        theme = themes[index]
    }

    @objc func previousTheme() {
        guard let index = themes.index(of: theme)?.advanced(by: -1), themes.indices.contains(index) else {
            return
        }

        theme = themes[index]
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
